From: Richard <tuxbox.guru@gmail.com>
Subject: Re: 2.6.25 pci=noacpi
Date: Thu, 08 May 2008 08:08:54 +0100
Message-ID: <4822A706.1040700@gmail.com>
References: <20080425183807.366134771@ldl.fc.hp.com> <20080425183934.516655076@ldl.fc.hp.com> <4813B5AB.4060308@keyaccess.nl> <200804281507.38309.bjorn.helgaas@hp.com> <4816C605.4000601@gmail.com> <481E0D2D.1030608@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757773AbYEHHJk@vger.kernel.org>
In-Reply-To: <481E0D2D.1030608@keyaccess.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

Rene Herman wrote:
> On 29-04-08 08:53, Richard wrote:
>
>> Using an AMD Sempron notebook (HP Compaq 6715b) single processor 
>> machine,  It shuts down during bootup when ACPI is fully enabled.  I 
>> added pci=noacpi to the cmdline and it finally boots, but its 
>> extremely slow...  (kdm times out with error saying it took too long 
>> to load and disables graphical)
>
> Does booting with io_delay=0xed on the kernel command line fix it? If 
> so, we need the output of
>
> # dmidecode -s baseboard-manufacturer
>
> and
>
> # dmidecode -s baseboard-product-name
>
> Rene.
>

Tried the io_delay=0xed.... doesnt fix it. machine shuts down :-P

Richard
