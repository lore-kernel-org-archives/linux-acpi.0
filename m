From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [ACPI] RE: PATCH/RFC: driver model/pmcore wakeup hooks (1/4)
Date: Tue, 19 Oct 2004 22:51:13 -0500
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200410192251.14740.dtor_core@ameritech.net>
References: <16A54BF5D6E14E4D916CE26C9AD3057559A042@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S268346AbUJTEdF@vger.kernel.org>
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD3057559A042@pdsmsx402.ccr.corp.intel.com>
Content-Disposition: inline
To: acpi-devel@lists.sourceforge.net
Cc: "Li, Shaohua" <shaohua.li@intel.com>, David Brownell <david-b@pacbell.net>, "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday 19 October 2004 04:11 am, Li, Shaohua wrote:
> A final solution is device core adds an ACPI layer. That is we can link
> ACPI device and physical device. This way, the PCI device can know which
> ACPI is linked with it, so the PCI API can use specific ACPI method. 
> You are right, we currently haven't a method to reach the goal. To match
> a physical device and ACPI device, we need to know the ACPI device's
> _ADR and bus.
> I have a toy to link the PCI device and ACPI device, and some PCI
> function can use _SxD method and _PSx method to get some information for
> suspend/resume.
> 

The only caveat is that PCI core should not depend on ACPI because it is not
available on all platforms, not all world is x86.

-- 
Dmitry
