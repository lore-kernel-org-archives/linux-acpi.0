From: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] device property: Fix reading pset strings using
 array access functions
Date: Wed, 8 Mar 2017 07:51:50 +0800
Message-ID: <201703080700.fRF37qL2%fengguang.wu@intel.com>
References: <1488806791-25488-3-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1488806791-25488-3-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Sakari,

[auto build test WARNING on driver-core/driver-core-testing]
[also build test WARNING on v4.11-rc1]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sakari-Ailus/Fwnode-property-API-fixes-for-OF-pset/20170308-072028
config: i386-tinyconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   drivers/base/property.c: In function '__fwnode_property_read_string_array':
>> drivers/base/property.c:564:8: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      prop = pset_prop_get(node, propname);
           ^

vim +/const +564 drivers/base/property.c

   548			return val ?
   549				of_property_read_string_array(to_of_node(fwnode),
   550							      propname, val, nval) :
   551				of_property_count_strings(to_of_node(fwnode), propname);
   552		else if (is_acpi_node(fwnode))
   553			return acpi_node_prop_read(fwnode, propname, DEV_PROP_STRING,
   554						   val, nval);
   555		else if (is_pset_node(fwnode)) {
   556			struct property_set *node = to_pset_node(fwnode);
   557			struct property_entry *prop;
   558	
   559			/* Read properties if val is non-NULL */
   560			if (val)
   561				return pset_prop_read_string_array(node, propname,
   562								   val, nval);
   563	
 > 564			prop = pset_prop_get(node, propname);
   565			if (!prop)
   566				return -EINVAL;
   567	
   568			/* The array length for a non-array string property is 1. */
   569			if (!prop->is_array)
   570				return 1;
   571	
   572			/* Return the length of an array. */

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--dDRMvlgZJXvWKvBx
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
4D8c1f2flVwAAA==

--dDRMvlgZJXvWKvBx--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
