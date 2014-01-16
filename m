From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 0/3] ACPI: Integrate tools/power/acpi Makefile into
 tools Makefile.
Date: Thu, 16 Jan 2014 01:02:08 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88024A9DFA@SHSMSX101.ccr.corp.intel.com>
References: <cover.1376378577.git.lv.zheng@intel.com>
 <cover.1389676901.git.lv.zheng@intel.com> <52D6BFA9.80609@redhat.com>
 <1A7043D5F58CCB44A599DFD55ED4C948452C20CD@FMSMSX106.amr.corp.intel.com>
 <52D70232.2030809@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:53246 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751875AbaAPBCa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jan 2014 20:02:30 -0500
In-Reply-To: <52D70232.2030809@redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <ahs3@redhat.com>, "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi,

> From: Al Stone [mailto:ahs3@redhat.com]
> Sent: Thursday, January 16, 2014 5:49 AM
> 
> On 01/15/2014 02:43 PM, Brown, Len wrote:
> >> Is there any work going on to reconcile (or merge or ...) this
> >> version of acpidump with the version in upstream ACPICA?  The
> >> sources are very different yet they seem to me to provide more
> >> or less the same functionality.
> >
> > Yes, that is exactly what is going on.
> > The acpidump in the kernel tree today is what we've been using for years.
> 
> Right.
> 
> > The acpidump in the ACPICA tree its newly developed replacement.
> > When we cut over to the new, it will replace the old.
> 
> Ah, okay.
> 
> > There is no big feature change here -- mostly the idea is
> > simply that more benefit from sharing the code maintained in the
> > upstream ACPICA source tree.
> >
> > cheers,
> > -Len
> >
> 
> Thanks, Len.  I suspected that might be the case.  That's good to
> hear -- it makes my life a little easier maintaining the distro
> packages for the ACPCICA user space tools.

I've commits to change ACPICA release scripts to include acpidump.
If they were merged by ACPICA upstream, the acpidump maintained by ACPICA will replace the old one maintained in the kernel tools/power/acpi folder.
And the tools/power/acpi folder will be automatically updated by the ACPICA release cycle from then on.

Thanks and best regards
-Lv

> 
> --
> ciao,
> al
> -----------------------------------
> Al Stone
> Software Engineer
> Red Hat, Inc.
> ahs3@redhat.com
> -----------------------------------
