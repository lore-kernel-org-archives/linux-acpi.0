From: Zhang Rui <rui.zhang@intel.com>
Subject: RE: Why is Scope(_TZ_) defined as ACPI_TYPE_THERMAL rather than
 ACPI_TYPE_LOCAL_SCOPE
Date: Tue, 21 Sep 2010 08:16:31 +0800
Message-ID: <1285028191.2111.3472.camel@rui>
References: <1284966497.2111.3460.camel@rui>
	 <4911F71203A09E4D9981D27F9D830858AF29BF79@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:14335 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755113Ab0IUAQD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Sep 2010 20:16:03 -0400
In-Reply-To: <4911F71203A09E4D9981D27F9D830858AF29BF79@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>, "Brown, Len" <lenb@kernel.org>

Hi, bob,

On Tue, 2010-09-21 at 04:29 +0800, Moore, Robert wrote:
> The comment appears to be correct as far as notifies on _TZ. I easily found a couple machines:
> 
> C:\ACPI_PREVIOUS\ASLFILES\DSDT DATABASE\Benq-Joybook_6000-017-original.asl(3652):                            Notify (\_TZ, 0x80)
> C:\ACPI_PREVIOUS\ASLFILES\DSDT DATABASE\Benq-Joybook_7000-R202-custom.asl(3247):                            Notify (\_TZ, 0x80)
> C:\ACPI_PREVIOUS\ASLFILES\DSDT DATABASE\Toshiba-Tecra_S1-2.30-custom.asl(708):                        Notify (\_TZ, 0x80)
> C:\ACPI_PREVIOUS\ASLFILES\DSDT DATABASE\Toshiba-Tecra_S1-2.30-custom.asl(723):                        Notify (\_TZ, 0x80)
> C:\ACPI_PREVIOUS\ASLFILES\DSDT DATABASE\Toshiba-Tecra_S1-2.30-custom.asl(3560):                        Notify (\_TZ, 0x80)
> 

what does Notify (\_TZ, 0x80) mean?
_TZ doesn't have _TMP method as it's not an thermal zone actually.
So what action should be taken when evaluating this ASL code?

Plus, if we really want "Notify(\_TZ, 0x80)", we can use
ACPI_TYPE_DEVICE rather than ACPI_TYPE_THERMAL, right?

thanks,
rui
> 
> 
> 
> >-----Original Message-----
> >From: Zhang, Rui
> >Sent: Monday, September 20, 2010 12:08 AM
> >To: Moore, Robert
> >Cc: linux-acpi@vger.kernel.org; Lin, Ming M; Brown, Len
> >Subject: Why is Scope(_TZ_) defined as ACPI_TYPE_THERMAL rather than
> >ACPI_TYPE_LOCAL_SCOPE
> >
> >Hi, Bob,
> >
> >this is the code in utglobal.c,
> >/*
> > * Predefined ACPI Names (Built-in to the Interpreter)
> > *
> > * NOTES:
> > * 1) _SB_ is defined to be a device to allow \_SB_._INI to be run
> > *    during the initialization sequence.
> > * 2) _TZ_ is defined to be a thermal zone in order to allow ASL code to
> > *    perform a Notify() operation on it.
> > */
> >const struct acpi_predefined_names acpi_gbl_pre_defined_names[] = {
> >        {"_GPE", ACPI_TYPE_LOCAL_SCOPE, NULL},
> >        {"_PR_", ACPI_TYPE_LOCAL_SCOPE, NULL},
> >        {"_SB_", ACPI_TYPE_DEVICE, NULL},
> >        {"_SI_", ACPI_TYPE_LOCAL_SCOPE, NULL},
> >        {"_TZ_", ACPI_TYPE_THERMAL, NULL},
> >        {"_REV", ACPI_TYPE_INTEGER, (char *)ACPI_CA_SUPPORT_LEVEL},
> >        {"_OS_", ACPI_TYPE_STRING, ACPI_OS_NAME},
> >        {"_GL_", ACPI_TYPE_MUTEX, (char *)1},
> >
> >I found a problem that Linux thermal driver tries to probe _TZ_ because
> >the _TZ_ ACPI namespace node type suggests it's a thermal device.
> >
> >I'm wondering why it's a device rather than a scope.
> >The comment above says ASL code may perform a Notify() operation on it,
> >but IMO, this notification is meaningless on its own, because _TZ_ can
> >neither detect the temperature, nor cool the system down, i.e. no action
> >should be taken on this notification.
> >
> >So I think we should change the type to ACPI_TYPE_LOCAL_SCOPE, just like
> >_PR_, _GPE.
> >
> >BTW: yes, we can do the tricks in Linux/ACPI code, but it's more likely
> >an ACPICA problem. what do you think?
> >
> >thanks,
> >rui
> 


