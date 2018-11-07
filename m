From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 4/6] drivers: base: Introducing software nodes to the
 firmware node framework
Date: Wed, 7 Nov 2018 14:33:35 +0200
Message-ID: <20181107123335.GF13048@kuha.fi.intel.com>
References: <20181105145928.46819-5-heikki.krogerus@linux.intel.com>
 <20181107043933.wqszrfajrfy6hv7u@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181107043933.wqszrfajrfy6hv7u@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: kbuild@01.org, kbuild-all@01.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Nov 07, 2018 at 07:39:33AM +0300, Dan Carpenter wrote:
> Hi Heikki,
> 
> url:    https://github.com/0day-ci/linux/commits/Heikki-Krogerus/device-property-Introducing-software-nodes/20181106-031310
> 
> smatch warnings:
> drivers/base/swnode.c:391 fwnode_create_software_node() error: dereferencing freed memory 'swnode'
> 
> # https://github.com/0day-ci/linux/commit/a8c9678ea46a0171baed68e4ec355a9b3f967458
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout a8c9678ea46a0171baed68e4ec355a9b3f967458
> vim +/swnode +391 drivers/base/swnode.c
> 
> a8c9678e Heikki Krogerus 2018-11-05  365  
> a8c9678e Heikki Krogerus 2018-11-05  366  struct fwnode_handle *
> a8c9678e Heikki Krogerus 2018-11-05  367  fwnode_create_software_node(const struct property_entry *properties,
> a8c9678e Heikki Krogerus 2018-11-05  368  			    const struct fwnode_handle *parent)
> a8c9678e Heikki Krogerus 2018-11-05  369  {
> a8c9678e Heikki Krogerus 2018-11-05  370  	struct software_node *p = NULL;
> a8c9678e Heikki Krogerus 2018-11-05  371  	struct software_node *swnode;
> a8c9678e Heikki Krogerus 2018-11-05  372  	char node_name[20];
> a8c9678e Heikki Krogerus 2018-11-05  373  	int ret;
> a8c9678e Heikki Krogerus 2018-11-05  374  
> a8c9678e Heikki Krogerus 2018-11-05  375  	if (parent) {
> a8c9678e Heikki Krogerus 2018-11-05  376  		if (IS_ERR(parent))
> a8c9678e Heikki Krogerus 2018-11-05  377  			return ERR_CAST(parent);
> a8c9678e Heikki Krogerus 2018-11-05  378  		if (!is_software_node(parent))
> a8c9678e Heikki Krogerus 2018-11-05  379  			return ERR_PTR(-EINVAL);
> a8c9678e Heikki Krogerus 2018-11-05  380  		p = to_software_node(parent);
> a8c9678e Heikki Krogerus 2018-11-05  381  	}
> a8c9678e Heikki Krogerus 2018-11-05  382  
> a8c9678e Heikki Krogerus 2018-11-05  383  	swnode = kzalloc(sizeof(*swnode), GFP_KERNEL);
> a8c9678e Heikki Krogerus 2018-11-05  384  	if (!swnode)
> a8c9678e Heikki Krogerus 2018-11-05  385  		return ERR_PTR(-ENOMEM);
> a8c9678e Heikki Krogerus 2018-11-05  386  
> a8c9678e Heikki Krogerus 2018-11-05  387  	swnode->id = ida_simple_get(p ? &p->child_ids : &swnode_root_ids, 0, 0,
> a8c9678e Heikki Krogerus 2018-11-05  388  				    GFP_KERNEL);
> a8c9678e Heikki Krogerus 2018-11-05  389  	if (swnode->id < 0) {
> a8c9678e Heikki Krogerus 2018-11-05  390  		kfree(swnode);
>                                                               ^^^^^^
> a8c9678e Heikki Krogerus 2018-11-05 @391  		return ERR_PTR(swnode->id);
>                                                                        ^^^^^^^^^^
> a8c9678e Heikki Krogerus 2018-11-05  392  	}

Thanks!

-- 
heikki
