From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] ACPI: properties: expose device properties
 through sysfs
Date: Thu, 28 Jun 2018 16:03:06 +0300
Message-ID: <20180628130306.2yu42sez52q65nra@mwanda>
References: <1530121294-13916-1-git-send-email-curt@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kbuild-bounces@lists.01.org>
Content-Disposition: inline
In-Reply-To: <1530121294-13916-1-git-send-email-curt@cumulusnetworks.com>
List-Unsubscribe: <https://lists.01.org/mailman/options/kbuild>,
 <mailto:kbuild-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/kbuild/>
List-Post: <mailto:kbuild@lists.01.org>
List-Help: <mailto:kbuild-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/kbuild>,
 <mailto:kbuild-request@lists.01.org?subject=subscribe>
Errors-To: kbuild-bounces@lists.01.org
Sender: "kbuild" <kbuild-bounces@lists.01.org>
To: kbuild@01.org, Curt Brune <curt@cumulusnetworks.com>
Cc: linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com, kbuild-all@01.org, sakari.ailus@linux.intel.com
List-Id: linux-acpi@vger.kernel.org

[ We are working on a bug in the kbuild scripts but right now the
  warnings aren't getting displayed so it's up to me to find a bug
  Smatch *would* have complained about.  - dan ]

Hi Curt,

Thank you for the patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/Curt-Brune/ACPI-properties-expose-device-properties-through-sysfs/20180628-023020
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next

# https://github.com/0day-ci/linux/commit/ac7a4f1b39af207f1fc7630f13d9e04314efae60
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout ac7a4f1b39af207f1fc7630f13d9e04314efae60
vim +/sysfs_name +822 drivers/acpi/device_sysfs.c

ac7a4f1b Curt Brune 2018-06-27  789  
ac7a4f1b Curt Brune 2018-06-27  790  static void acpi_property_remove_attr(struct acpi_device *adev,
ac7a4f1b Curt Brune 2018-06-27  791  				      const char *property)
ac7a4f1b Curt Brune 2018-06-27  792  {
ac7a4f1b Curt Brune 2018-06-27  793  	struct attribute attr = { 0 };
ac7a4f1b Curt Brune 2018-06-27  794  	const union acpi_object *obj;
ac7a4f1b Curt Brune 2018-06-27  795  	struct acpi_reference_args args;
ac7a4f1b Curt Brune 2018-06-27  796  	char *sysfs_name;
ac7a4f1b Curt Brune 2018-06-27  797  	int idx;
ac7a4f1b Curt Brune 2018-06-27  798  	int err;
ac7a4f1b Curt Brune 2018-06-27  799  
ac7a4f1b Curt Brune 2018-06-27  800  	err = acpi_dev_get_property(adev, property, ACPI_TYPE_ANY, &obj);
ac7a4f1b Curt Brune 2018-06-27  801  	if (err)
ac7a4f1b Curt Brune 2018-06-27  802  		return;
ac7a4f1b Curt Brune 2018-06-27  803  
ac7a4f1b Curt Brune 2018-06-27  804  	attr.name = property;
ac7a4f1b Curt Brune 2018-06-27  805  	sysfs_remove_file(&adev->data.kobj, &attr);
ac7a4f1b Curt Brune 2018-06-27  806  
ac7a4f1b Curt Brune 2018-06-27  807  	idx = 0;
ac7a4f1b Curt Brune 2018-06-27  808  	while (__acpi_dev_get_property_reference(adev, property, idx,
ac7a4f1b Curt Brune 2018-06-27  809  						 &args) == 0) {
ac7a4f1b Curt Brune 2018-06-27  810  		if (idx == 0)
ac7a4f1b Curt Brune 2018-06-27  811  			sysfs_name = kasprintf(GFP_KERNEL, "%s", property);
ac7a4f1b Curt Brune 2018-06-27  812  		else
ac7a4f1b Curt Brune 2018-06-27  813  			sysfs_name = kasprintf(GFP_KERNEL, "%s%u", property,
ac7a4f1b Curt Brune 2018-06-27  814  					       idx);
ac7a4f1b Curt Brune 2018-06-27  815  		if (!sysfs_name)
ac7a4f1b Curt Brune 2018-06-27  816  			continue;
ac7a4f1b Curt Brune 2018-06-27  817  
ac7a4f1b Curt Brune 2018-06-27  818  		sysfs_remove_link(&adev->data.kobj, sysfs_name);
ac7a4f1b Curt Brune 2018-06-27  819  		kfree(sysfs_name);
                                                      ^^^^^^^^^^
ac7a4f1b Curt Brune 2018-06-27  820  
ac7a4f1b Curt Brune 2018-06-27  821  		if (args.nargs > 0) {
ac7a4f1b Curt Brune 2018-06-27 @822  			attr.name = kasprintf(GFP_KERNEL, "%s_args",
ac7a4f1b Curt Brune 2018-06-27  823  					      sysfs_name);
                                                                              ^^^^^^^^^^
Use after free.

ac7a4f1b Curt Brune 2018-06-27  824  			if (!attr.name)
ac7a4f1b Curt Brune 2018-06-27  825  				continue;
ac7a4f1b Curt Brune 2018-06-27  826  
ac7a4f1b Curt Brune 2018-06-27  827  			sysfs_remove_file(&adev->data.kobj, &attr);
ac7a4f1b Curt Brune 2018-06-27  828  			kfree(attr.name);
ac7a4f1b Curt Brune 2018-06-27  829  		}
ac7a4f1b Curt Brune 2018-06-27  830  
ac7a4f1b Curt Brune 2018-06-27  831  		idx++;
ac7a4f1b Curt Brune 2018-06-27  832  	}
ac7a4f1b Curt Brune 2018-06-27  833  }
ac7a4f1b Curt Brune 2018-06-27  834  
