From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: Kernel Freeze with American Megatrends BIOS
Date: Tue, 30 Aug 2016 16:48:59 +0100
Message-ID: <CACvgo51gNzECupX6R7jwQndH-1rX6MN1kPquuikzJrPk3CeZVA@mail.gmail.com>
References: <004c7dbe-2014-c691-29d1-7a45f3b73dfa@desertbit.com>
 <20160829160210.GA24451@localhost> <1cca943f-eab4-4054-4a13-31370d7ae057@desertbit.com>
 <20160829190737.GA4053@localhost> <a0079ace-3062-4792-5c33-3a5e350daac3@desertbit.com>
 <20160829235403.GA14177@localhost> <1d1bfdc2-f23d-9816-e4e3-ae676105dc39@desertbit.com>
 <20160830130634.GA16426@localhost> <CACvgo51b4XLz2PwH1dkcK4_FknfZkSUKsFepYz-AGfPr7ux2kA@mail.gmail.com>
 <735da66c-aaf3-8c27-2d59-f62e8c85d3aa@desertbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34887 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753595AbcH3PtC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Aug 2016 11:49:02 -0400
In-Reply-To: <735da66c-aaf3-8c27-2d59-f62e8c85d3aa@desertbit.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Roland Singer <roland.singer@desertbit.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, linux-acpi@vger.kernel.org

On 30 August 2016 at 16:25, Roland Singer <roland.singer@desertbit.com> wrote:
> I tried these scenarios:
>
> 1. Booted the system without the bbswitch module. The nouveau module
>    was loaded and is responsible for the power management of the GPU.
>    The graphical session freezes after some minutes...
>
> 2. Booted the system without bbswitch and with nouveau blacklisted.
>    Manually loaded bbswitch to switch off the discrete GPU.
>    Same freeze after a while or by explicitly obtaining the GPU state.
>
> Is there a possibility to switch off the discrete card without bbswitch?
> If this is possible, then I could test this without nouveau and bbswitch
> at all. If the system hangs, then it is not the video driver nor bbswitch.
>
As Ilia mentioned acpi_call should do it. You can also check with the
nouveau/bbwswitch code to see which ones they use in your case and
bash it manually. It might be that the 'wrong one' gets used thus
things going horribly wrong.

Regards,
Emil
