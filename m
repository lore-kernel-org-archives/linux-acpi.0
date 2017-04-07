From: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 5/8] v4l: Switch from V4L2 OF not V4L2 fwnode API
Date: Fri, 7 Apr 2017 14:19:05 +0800
Message-ID: <201704071415.D8yNB69C%fengguang.wu@intel.com>
References: <1491484249-11964-6-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1491484249-11964-6-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, linux-media-8fOc0yYH5q9zeIdxy0IIJw@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Sakari,

[auto build test ERROR on linuxtv-media/master]
[also build test ERROR on next-20170406]
[cannot apply to v4.11-rc5]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sakari-Ailus/v4l-flash-led-class-Use-fwnode_handle-instead-of-device_node-in-init/20170407-133451
base:   git://linuxtv.org/media_tree.git master
config: i386-randconfig-x016-201714 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   In file included from drivers/media/i2c/tvp5150.c:19:0:
>> include/media/v4l2-fwnode.h:67:25: error: field 'base' has incomplete type
     struct fwnode_endpoint base;
                            ^~~~
   drivers/media/i2c/tvp5150.c: In function 'tvp5150_parse_dt':
>> drivers/media/i2c/tvp5150.c:1377:35: error: implicit declaration of function 'of_fwnode_handle' [-Werror=implicit-function-declaration]
     ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(ep), &bus_cfg);
                                      ^~~~~~~~~~~~~~~~
>> drivers/media/i2c/tvp5150.c:1377:35: warning: passing argument 1 of 'v4l2_fwnode_endpoint_parse' makes pointer from integer without a cast [-Wint-conversion]
   In file included from drivers/media/i2c/tvp5150.c:19:0:
   include/media/v4l2-fwnode.h:95:5: note: expected 'struct fwnode_handle *' but argument is of type 'int'
    int v4l2_fwnode_endpoint_parse(struct fwnode_handle *fwn,
        ^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/media/i2c/tvp514x.c:41:0:
>> include/media/v4l2-fwnode.h:67:25: error: field 'base' has incomplete type
     struct fwnode_endpoint base;
                            ^~~~
   drivers/media/i2c/tvp514x.c: In function 'tvp514x_get_pdata':
>> drivers/media/i2c/tvp514x.c:1012:33: error: implicit declaration of function 'of_fwnode_handle' [-Werror=implicit-function-declaration]
     if (v4l2_fwnode_endpoint_parse(of_fwnode_handle(endpoint), &bus_cfg))
                                    ^~~~~~~~~~~~~~~~
>> drivers/media/i2c/tvp514x.c:1012:33: warning: passing argument 1 of 'v4l2_fwnode_endpoint_parse' makes pointer from integer without a cast [-Wint-conversion]
   In file included from drivers/media/i2c/tvp514x.c:41:0:
   include/media/v4l2-fwnode.h:95:5: note: expected 'struct fwnode_handle *' but argument is of type 'int'
    int v4l2_fwnode_endpoint_parse(struct fwnode_handle *fwn,
        ^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/media/i2c/tvp7002.c:36:0:
>> include/media/v4l2-fwnode.h:67:25: error: field 'base' has incomplete type
     struct fwnode_endpoint base;
                            ^~~~
   drivers/media/i2c/tvp7002.c: In function 'tvp7002_get_pdata':
>> drivers/media/i2c/tvp7002.c:904:33: error: implicit declaration of function 'of_fwnode_handle' [-Werror=implicit-function-declaration]
     if (v4l2_fwnode_endpoint_parse(of_fwnode_handle(endpoint), &bus_cfg))
                                    ^~~~~~~~~~~~~~~~
>> drivers/media/i2c/tvp7002.c:904:33: warning: passing argument 1 of 'v4l2_fwnode_endpoint_parse' makes pointer from integer without a cast [-Wint-conversion]
   In file included from drivers/media/i2c/tvp7002.c:36:0:
   include/media/v4l2-fwnode.h:95:5: note: expected 'struct fwnode_handle *' but argument is of type 'int'
    int v4l2_fwnode_endpoint_parse(struct fwnode_handle *fwn,
        ^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/media/v4l2-core/v4l2-fwnode.c:26:0:
>> include/media/v4l2-fwnode.h:67:25: error: field 'base' has incomplete type
     struct fwnode_endpoint base;
                            ^~~~
   drivers/media/v4l2-core/v4l2-fwnode.c: In function 'v4l2_fwnode_endpoint_parse':
>> drivers/media/v4l2-core/v4l2-fwnode.c:170:2: error: implicit declaration of function 'fwnode_graph_parse_endpoint' [-Werror=implicit-function-declaration]
     fwnode_graph_parse_endpoint(fwn, &vfwn->base);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-fwnode.c: In function 'v4l2_fwnode_parse_link':
>> drivers/media/v4l2-core/v4l2-fwnode.c:301:8: error: implicit declaration of function 'fwnode_get_parent' [-Werror=implicit-function-declaration]
     fwn = fwnode_get_parent(__fwn);
           ^~~~~~~~~~~~~~~~~
>> drivers/media/v4l2-core/v4l2-fwnode.c:301:6: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     fwn = fwnode_get_parent(__fwn);
         ^
>> drivers/media/v4l2-core/v4l2-fwnode.c:303:8: error: implicit declaration of function 'fwnode_get_next_parent' [-Werror=implicit-function-declaration]
     fwn = fwnode_get_next_parent(fwn);
           ^~~~~~~~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-fwnode.c:303:6: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     fwn = fwnode_get_next_parent(fwn);
         ^
   drivers/media/v4l2-core/v4l2-fwnode.c:306:8: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
       fwn = fwnode_get_next_parent(fwn);
           ^
   drivers/media/v4l2-core/v4l2-fwnode.c:309:7: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      fwn = fwnode_get_next_parent(fwn);
          ^
>> drivers/media/v4l2-core/v4l2-fwnode.c:313:8: error: implicit declaration of function 'fwnode_graph_get_remote_endpoint' [-Werror=implicit-function-declaration]
     fwn = fwnode_graph_get_remote_endpoint(fwn);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-fwnode.c:313:6: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     fwn = fwnode_graph_get_remote_endpoint(fwn);
         ^
   drivers/media/v4l2-core/v4l2-fwnode.c:319:6: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     fwn = fwnode_get_parent(fwn);
         ^
   drivers/media/v4l2-core/v4l2-fwnode.c:321:6: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     fwn = fwnode_get_next_parent(fwn);
         ^
   drivers/media/v4l2-core/v4l2-fwnode.c:324:8: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
       fwn = fwnode_get_next_parent(fwn);
           ^
   drivers/media/v4l2-core/v4l2-fwnode.c:327:7: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      fwn = fwnode_get_next_parent(fwn);
          ^
   cc1: some warnings being treated as errors
--
   In file included from drivers/media//i2c/tvp5150.c:19:0:
>> include/media/v4l2-fwnode.h:67:25: error: field 'base' has incomplete type
     struct fwnode_endpoint base;
                            ^~~~
   drivers/media//i2c/tvp5150.c: In function 'tvp5150_parse_dt':
   drivers/media//i2c/tvp5150.c:1377:35: error: implicit declaration of function 'of_fwnode_handle' [-Werror=implicit-function-declaration]
     ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(ep), &bus_cfg);
                                      ^~~~~~~~~~~~~~~~
   drivers/media//i2c/tvp5150.c:1377:35: warning: passing argument 1 of 'v4l2_fwnode_endpoint_parse' makes pointer from integer without a cast [-Wint-conversion]
   In file included from drivers/media//i2c/tvp5150.c:19:0:
   include/media/v4l2-fwnode.h:95:5: note: expected 'struct fwnode_handle *' but argument is of type 'int'
    int v4l2_fwnode_endpoint_parse(struct fwnode_handle *fwn,
        ^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/media//i2c/tvp514x.c:41:0:
>> include/media/v4l2-fwnode.h:67:25: error: field 'base' has incomplete type
     struct fwnode_endpoint base;
                            ^~~~
   drivers/media//i2c/tvp514x.c: In function 'tvp514x_get_pdata':
   drivers/media//i2c/tvp514x.c:1012:33: error: implicit declaration of function 'of_fwnode_handle' [-Werror=implicit-function-declaration]
     if (v4l2_fwnode_endpoint_parse(of_fwnode_handle(endpoint), &bus_cfg))
                                    ^~~~~~~~~~~~~~~~
   drivers/media//i2c/tvp514x.c:1012:33: warning: passing argument 1 of 'v4l2_fwnode_endpoint_parse' makes pointer from integer without a cast [-Wint-conversion]
   In file included from drivers/media//i2c/tvp514x.c:41:0:
   include/media/v4l2-fwnode.h:95:5: note: expected 'struct fwnode_handle *' but argument is of type 'int'
    int v4l2_fwnode_endpoint_parse(struct fwnode_handle *fwn,
        ^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/media//i2c/tvp7002.c:36:0:
>> include/media/v4l2-fwnode.h:67:25: error: field 'base' has incomplete type
     struct fwnode_endpoint base;
                            ^~~~
   drivers/media//i2c/tvp7002.c: In function 'tvp7002_get_pdata':
   drivers/media//i2c/tvp7002.c:904:33: error: implicit declaration of function 'of_fwnode_handle' [-Werror=implicit-function-declaration]
     if (v4l2_fwnode_endpoint_parse(of_fwnode_handle(endpoint), &bus_cfg))
                                    ^~~~~~~~~~~~~~~~
   drivers/media//i2c/tvp7002.c:904:33: warning: passing argument 1 of 'v4l2_fwnode_endpoint_parse' makes pointer from integer without a cast [-Wint-conversion]
   In file included from drivers/media//i2c/tvp7002.c:36:0:
   include/media/v4l2-fwnode.h:95:5: note: expected 'struct fwnode_handle *' but argument is of type 'int'
    int v4l2_fwnode_endpoint_parse(struct fwnode_handle *fwn,
        ^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/media//v4l2-core/v4l2-fwnode.c:26:0:
>> include/media/v4l2-fwnode.h:67:25: error: field 'base' has incomplete type
     struct fwnode_endpoint base;
                            ^~~~
   drivers/media//v4l2-core/v4l2-fwnode.c: In function 'v4l2_fwnode_endpoint_parse':
   drivers/media//v4l2-core/v4l2-fwnode.c:170:2: error: implicit declaration of function 'fwnode_graph_parse_endpoint' [-Werror=implicit-function-declaration]
     fwnode_graph_parse_endpoint(fwn, &vfwn->base);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media//v4l2-core/v4l2-fwnode.c: In function 'v4l2_fwnode_parse_link':
   drivers/media//v4l2-core/v4l2-fwnode.c:301:8: error: implicit declaration of function 'fwnode_get_parent' [-Werror=implicit-function-declaration]
     fwn = fwnode_get_parent(__fwn);
           ^~~~~~~~~~~~~~~~~
   drivers/media//v4l2-core/v4l2-fwnode.c:301:6: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     fwn = fwnode_get_parent(__fwn);
         ^
   drivers/media//v4l2-core/v4l2-fwnode.c:303:8: error: implicit declaration of function 'fwnode_get_next_parent' [-Werror=implicit-function-declaration]
     fwn = fwnode_get_next_parent(fwn);
           ^~~~~~~~~~~~~~~~~~~~~~
   drivers/media//v4l2-core/v4l2-fwnode.c:303:6: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     fwn = fwnode_get_next_parent(fwn);
         ^
   drivers/media//v4l2-core/v4l2-fwnode.c:306:8: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
       fwn = fwnode_get_next_parent(fwn);
           ^
   drivers/media//v4l2-core/v4l2-fwnode.c:309:7: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      fwn = fwnode_get_next_parent(fwn);
          ^
   drivers/media//v4l2-core/v4l2-fwnode.c:313:8: error: implicit declaration of function 'fwnode_graph_get_remote_endpoint' [-Werror=implicit-function-declaration]
     fwn = fwnode_graph_get_remote_endpoint(fwn);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media//v4l2-core/v4l2-fwnode.c:313:6: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     fwn = fwnode_graph_get_remote_endpoint(fwn);
         ^
   drivers/media//v4l2-core/v4l2-fwnode.c:319:6: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     fwn = fwnode_get_parent(fwn);
         ^
   drivers/media//v4l2-core/v4l2-fwnode.c:321:6: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     fwn = fwnode_get_next_parent(fwn);
         ^
   drivers/media//v4l2-core/v4l2-fwnode.c:324:8: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
       fwn = fwnode_get_next_parent(fwn);
           ^
   drivers/media//v4l2-core/v4l2-fwnode.c:327:7: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      fwn = fwnode_get_next_parent(fwn);
          ^
   cc1: some warnings being treated as errors

vim +/base +67 include/media/v4l2-fwnode.h

8219f9b0 Sakari Ailus 2017-04-06  61   * @bus_type: bus type
8219f9b0 Sakari Ailus 2017-04-06  62   * @bus: bus configuration data structure
8219f9b0 Sakari Ailus 2017-04-06  63   * @link_frequencies: array of supported link frequencies
8219f9b0 Sakari Ailus 2017-04-06  64   * @nr_of_link_frequencies: number of elements in link_frequenccies array
8219f9b0 Sakari Ailus 2017-04-06  65   */
8219f9b0 Sakari Ailus 2017-04-06  66  struct v4l2_fwnode_endpoint {
8219f9b0 Sakari Ailus 2017-04-06 @67  	struct fwnode_endpoint base;
8219f9b0 Sakari Ailus 2017-04-06  68  	/*
8219f9b0 Sakari Ailus 2017-04-06  69  	 * Fields below this line will be zeroed by
8219f9b0 Sakari Ailus 2017-04-06  70  	 * v4l2_fwnode_parse_endpoint()

:::::: The code at line 67 was first introduced by commit
:::::: 8219f9b04bb5639303351ca63b349966aecb9537 v4l: fwnode: Support generic fwnode for parsing standardised properties

:::::: TO: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
:::::: CC: 0day robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--gBBFr7Ir9EOA20Yy
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
hLeikXMXjotEst//TXUKHpt3AQA=

--gBBFr7Ir9EOA20Yy--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
