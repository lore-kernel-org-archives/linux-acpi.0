From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: Toshiba Satellite L650D-10J only boots with acpi=off
Date: Sat, 28 Aug 2010 11:24:28 -0700
Message-ID: <AANLkTimaCQP61iDSHCAqBRZcEr3QQnfg1UdrHXzZ9xF4@mail.gmail.com>
References: <20100828192538.666c34c4.frank@61924.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100828192538.666c34c4.frank@61924.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Frank <frank@61924.nl>
Cc: linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Barnes, Jesse" <jesse.barnes@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Sat, Aug 28, 2010 at 10:25 AM, Frank <frank@61924.nl> wrote:
> Hello,
>
> I purchased a Toshiba Satellite L650D-10J a few days ago and when I
> wanted to install Archlinux I was only able to boot the installer with
> acpi=off. The same goes for the installed OS.
>
> I asked on ##kernel on freenode and one guy said I should mail this
> issue to this mailing list. And include all the information I have.
>
> This is what I get when I boot without acpi=off:
> http://i.imagehost.org/view/0872/DSC00071
> http://a.imagehost.org/view/0172/DSC00069
>
> The system boots normally when I use acpi=off, but the dual-core CPU is
> seen as a CPU with one core. And X is slow with starting up and doesn't
> shutdown when I close Openbox, but I'm not sure if that's even related.
>
> Here's the dmesg:
> http://codepad.org/W7EzULKf
>
> And the lspci:
> http://codepad.org/ce1boP3r
>
> I'm using the stock Archlinux x86_64 kernel (the latest is 2.6.35.3-1
> at this moment) and the config files can be found here:
> http://repos.archlinux.org/wsvn/packages/kernel26/repos/core-x86_64/
>
> If more information is needed, I'll glady provide it.
>

Can you try to boot with "pci=nocrs" instead of "acpi=off"?

Yinghai
