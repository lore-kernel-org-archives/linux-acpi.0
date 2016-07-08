From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [UPDATE RFC PATCH v2] ACPI / EC: Fix an order issue in
 ec_remove_handlers()
Date: Fri, 8 Jul 2016 00:38:04 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BC01BAE@SHSMSX101.ccr.corp.intel.com>
References: <20160706141410.GA1430@tetsubishi>
 <e48b77b7af1e8269b0ff3fac6cbf37eb480ab722.1467866123.git.lv.zheng@intel.com>
 <20160707114654.GA2915@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:55701 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753473AbcGHAiJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jul 2016 20:38:09 -0400
In-Reply-To: <20160707114654.GA2915@tetsubishi>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Nicholas <nkudriavtsev@gmail.com>

Hi,

> From: Wolfram Sang [mailto:wsa@the-dreams.de]
> Subject: Re: [UPDATE RFC PATCH v2] ACPI / EC: Fix an order issue in
> ec_remove_handlers()
> 
> On Thu, Jul 07, 2016 at 12:37:10PM +0800, Lv Zheng wrote:
> > (Updated to add v2 indicator)
> >
> > There is an order issue in ec_remove_handlers() that the functions
> invoked
> > in it are not invoked in the reversed order of their appearance in
> > ec_install_handlers(). This existing issue has been triggered by the
> > following commit:
> >   Commit: dcf15cbded656a12335bc4151f3f75f10080a375
> >   Subject: ACPI / EC: Fix a boot EC regresion by restoring boot EC
> > The commit invokes ec_remove_handlers() during runtime, thus
> uncovers this
> > issue. This patch fixes this regression.
> >
> > Fixes: dcf15cbded65 ("ACPI / EC: Fix a boot EC regresion by restoring
> boot EC")
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=102421
> > Reported-by: Wolfram Sang <wsa@the-dreams.de>
> > Reported-by: Nicholas <nkudriavtsev@gmail.com>
> > Cc: Wolfram Sang <wsa@the-dreams.de>
> > Cc: Nicholas <nkudriavtsev@gmail.com>
> > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> 
> Tested-by: Wolfram Sang <wsa@the-dreams.de>
> 
> The status infos are back to normal and the EC error reports are gone
> from the log. Looks good! Thanks for the quick fix.

[Lv Zheng] 
Thanks for the test, I'll refresh the patch with your tested-by added and RFC removed.

Best regards
-Lv
