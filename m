From: Tejun Heo <htejun@gmail.com>
Subject: Re: Serial ATA does not find partitions (Hitachi HD, new? ATI controller)
 where old SATA works
Date: Tue, 02 Oct 2007 15:51:29 +0900
Message-ID: <4701EA71.2000609@gmail.com>
References: <46FC4384.7080607@df.uba.ar> <46FCCD57.2020507@gmail.com> <47014740.5080002@df.uba.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <47014740.5080002@df.uba.ar>
Sender: linux-ide-owner@vger.kernel.org
To: hgsolari@gmail.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hernan Gustavo Solari wrote:
> Tejun
> 
>    netconsole, pritty nice debunging system... but (yes, there is always
> a but) it does not get to run.
>    the method was well implemented, adding the acpi=off it sends the
> information to the receiving machine (I can even see passing a
> netconsole probing message in the machine under testing), but without
> turning off acpi it does not reach the point of loading and,
> consequently, it does not send a byte to the receiving machine.
> 
> Hence, result: empty output.

Hmmm.. Are netconsole support and network driver built into the kernel?

-- 
tejun

