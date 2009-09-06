From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [BUG] partial and rare system freeze
Date: Sun, 6 Sep 2009 22:23:52 +0100
Message-ID: <200909062223.53399.carlos@strangeworlds.co.uk>
References: <1252271151.32726.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758780AbZIFVYL@vger.kernel.org>
In-Reply-To: <1252271151.32726.19.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sunday 06 Sep 2009 22:05:51 Maxim Levitsky wrote:

[..]

> [   79.101221] ACPI Error (dswload-0790): [_T_0] Namespace lookup failure,
> AE_ALREADY_EXISTS [   79.101232] ACPI Exception: AE_ALREADY_EXISTS, During
> name lookup/catalog 20090521 psloop-227 [   79.101240] ACPI Error
> (psparse-0537): Method parse/execution failed [\_SB_.PCI0.WMID.WMBA] (Node
> ffff88007f8400c0), AE_ALREADY_EXISTS [   79.101254] ACPI: Marking method
> WMBA as Serialized because of AE_ALREADY_EXISTS error
>
> Is very likely due to acer-wmi module I use to control brightness.

[..]

> [  240.702830]  [<ffffffff8125066e>] acpi_ns_evaluate+0x236/0x3bc
> [  240.702838]  [<ffffffff8124fb27>] acpi_evaluate_object+0x265/0x3cc
> [  240.702861]  [<ffffffffa09c56fa>] wmi_evaluate_method+0x10a/0x130 [wmi]
> [  240.702869]  [<ffffffff81040956>] ? finish_task_switch+0x46/0x120
> [  240.702877]  [<ffffffff813b3c9c>] ? thread_return+0x9f/0x723
> [  240.702889]  [<ffffffffa0a9d7d0>] ? acer_rfkill_update+0x0/0xa0
> [acer_wmi] [  240.702899]  [<ffffffffa0a9d17c>] WMI_execute_u32+0x4c/0x90
> [acer_wmi] [  240.702911]  [<ffffffffa0a9d620>] get_u32+0x90/0x100
> [acer_wmi] [  240.702918]  [<ffffffff8105d19a>] ? worker_thread+0x1ca/0x390
> [  240.702928]  [<ffffffffa0a9d7ea>] acer_rfkill_update+0x1a/0xa0

This is acer-wmi doing its' once per minute poll to check the wireless rfkill 
status. But I've no idea why that would spontaneously cause ACPI to fall over.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
