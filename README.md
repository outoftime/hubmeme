## HubMeme

HubMeme is a whimsical command-line tool to figure out how big a meme a user is
on GitHub. Meme-ness is calculated by summing over all repositories a user has
contributed to the product of their percentage contribution and the number of
stars the repository has.

### Installation

```bash
$ gem install hubmeme
```

### Running it

You'll need a [GitHub access
token](https://help.github.com/articles/creating-an-access-token-for-command-line-use).

```bash
$ GITHUB_ACCESS_TOKEN=something hubmeme username
```

### How it works

1. Tries to figure out all the repositories you've contributed to. GitHub
   doesn't make this directly accessible via the API as far as I can tell, so it
   checks your own repos; your organizations' repos; repos you've starred; repos
   you've made pull requests to; etc.
2. Calculates your percentage contribution on each repo. The is using the
   [“contributors”
   endpoint](http://developer.github.com/v3/repos/#list-contributors) on the
   GitHub API; I'm not even sure exactly what the “contributions” number means,
   and it doesn't seem terribly accurate, but the stakes are pretty low here.
3. Sums up the product of your contribution to each repo and the number of stars
   that repo has.
4. Prints all that on the screen.

Here's what it prints out for me (all my friends are more meme):

```
         brewster/elastictastic   80%      73         59
            brewster/shearwater   72%       2          1
                  cequel/cequel   96%      61         59
        kreynolds/cassandra-cql    9%      71          7
                mongoid/mongoid    0%    2771          1
         outoftime/eager_record   64%      35         23
              outoftime/get_lit   82%       1          1
                 outoftime/harp  100%       3          3
       outoftime/native_support  100%       3          3
                 outoftime/noaa   33%      68         23
              outoftime/ottoman  100%       6          6
 outoftime/outoftime.github.com  100%       2          2
            outoftime/patch_log  100%       1          1
       outoftime/search-contrib  100%       1          1
outoftime/sunspot-rails-example   87%      13         11
        outoftime/sunspot_rails    6%     128          8
            outoftime/woodchuck  100%       1          1
                sunspot/sunspot    8%    1808        145
TOTAL MEME: 354
```

### Known problems

* See items 1 and 2 under “How it works”
* Enables the worst kind of open-source navel-gazing; may end friendships

### Contributing

Go for it!

### License

Released under the MIT license copyright 2013 Mat Brown and his cat. See
attached LICENSE for details.
