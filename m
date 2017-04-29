From: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] virtio, rpmsg: switch to dynamic_hex_dump()
Date: Sat, 29 Apr 2017 16:46:10 +0800
Message-ID: <201704291610.sI4vYOud%fengguang.wu@intel.com>
References: <149341494418.35578.561981766577089185.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <149341494418.35578.561981766577089185.stgit-p8uTFz9XbKj2zm6wflaqv1nYeNYlB/vhral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, linux-remoteproc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kbuild-all-JC7UmRfGjtg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Dan,

[auto build test ERROR on pm/linux-next]
[also build test ERROR on v4.11-rc8 next-20170428]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dan-Williams/dynamic_hex_dump-cleanup/20170429-135503
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: arm-multi_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers//rpmsg/virtio_rpmsg_bus.c: In function 'rpmsg_send_offchannel_raw':
>> drivers//rpmsg/virtio_rpmsg_bus.c:602:2: error: implicit declaration of function 'dynamic_hex_dump' [-Werror=implicit-function-declaration]
     dynamic_hex_dump("rpmsg_virtio TX: ", DUMP_PREFIX_NONE, 16, 1,
     ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/dynamic_hex_dump +602 drivers//rpmsg/virtio_rpmsg_bus.c

bcabbcca Ohad Ben-Cohen 2011-10-20  596  	msg->dst = dst;
bcabbcca Ohad Ben-Cohen 2011-10-20  597  	msg->reserved = 0;
bcabbcca Ohad Ben-Cohen 2011-10-20  598  	memcpy(msg->data, data, len);
bcabbcca Ohad Ben-Cohen 2011-10-20  599  
bcabbcca Ohad Ben-Cohen 2011-10-20  600  	dev_dbg(dev, "TX From 0x%x, To 0x%x, Len %d, Flags %d, Reserved %d\n",
0963679c Anna, Suman    2016-08-12  601  		msg->src, msg->dst, msg->len, msg->flags, msg->reserved);
211e3a93 Anna, Suman    2016-08-12 @602  	dynamic_hex_dump("rpmsg_virtio TX: ", DUMP_PREFIX_NONE, 16, 1,
bcabbcca Ohad Ben-Cohen 2011-10-20  603  			 msg, sizeof(*msg) + msg->len, true);
bcabbcca Ohad Ben-Cohen 2011-10-20  604  
bcabbcca Ohad Ben-Cohen 2011-10-20  605  	sg_init_one(&sg, msg, sizeof(*msg) + len);

:::::: The code at line 602 was first introduced by commit
:::::: 211e3a93e5b5933e64ddfb299eee462ac7c7d500 rpmsg: use dynamic_hex_dump for hex dump traces

:::::: TO: Anna, Suman <s-anna-l0cyMroinI0@public.gmane.org>
:::::: CC: Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
