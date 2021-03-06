require 'rails_helper'

describe 'hot ranking page' do
	context 'when a user goes to the hot page' do 

		before(:each) do 
				Timecop.freeze(Time.local(2014, 8, 1, 10 ,5, 0)) do 
					@hot_post = create(:hot_post)
					10.times{@hot_post.upvotes.create}
					@not_hot_post = create(:not_hot_post)
				end
		end

		it 'They will see pages ranked in order of newness and popularity' do 
			visit '/posts'
			click_link 'hot'
			expect(page.body.index(@hot_post.title)).to be < page.body.index(@not_hot_post.title)
		end
	end
end

describe 'controversial ranking page' do
	context 'when a user goes to the hot page' do 

		before(:each) do 
					@controversial_post = create(:controversial_post)
					10.times{@controversial_post.upvotes.create}
					7.times{@controversial_post.downvotes.create}
					@uncontroversial_post = create(:post)
					10.times{@uncontroversial_post.upvotes.create}
		end

		it 'They will see pages ranked in order of newness and popularity' do 
			visit '/posts'
			click_link 'controversial'
			expect(page.body.index(@controversial_post.title)).to be < page.body.index(@uncontroversial_post.title)
		end
	end
end

describe ' newest ranking page' do 
	context 'when a user goes to the newest page' do 
		
		before(:each) do 
			@oldest = create(:post)
			@newest = create(:hot_post)
		end

		it 'posts will be displayed in chronological order' do 
			visit '/posts'
			click_link 'newest'
			expect(page.body.index(@newest.title)).to be < page.body.index(@oldest.title)
		end
	end

end

describe 'rising ranking page' do 
	context 'when a user goes to the rising page' do
		before(:each) do
			@rising_post = create(:hot_post)
			@post = create(:post)
			10.times{@rising_post.upvotes.create}
		end 
		it 'posts will be displayed according to which ones are rising in popularity' do 
			visit '/posts'
			click_link 'rising'
			expect(page.body.index(@rising_post.title)).to be < page.body.index(@post.title)
		end
	end
end

describe 'top ranking page' do 
	context ' when a user visits the top page' do 
		before(:each) do
			@top_post = create(:hot_post)
			@post = create(:post)
			10.times{@top_post.upvotes.create}
		end

		it 'posts will be displayed accoring to the number of votes they have' do 
			visit '/posts'
			click_link 'top'
			expect(page.body.index(@top_post.title)).to be < page.body.index(@post.title)
		end
	end

end