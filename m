From: Andy Lutomirski <luto@myrealbox.com>
Subject: Re: Low-Level and Long-Term Battery Control
Date: Mon, 19 Apr 2010 00:31:29 -0400
Message-ID: <4BCBDCA1.9030500@myrealbox.com>
References: <w2r45cc95261004130535y80da503ev5389bb4a97bdd58f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <w2r45cc95261004130535y80da503ev5389bb4a97bdd58f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Mohamed Ikbel Boulabiar wrote:
> Hi,
> 
> Is there any function in the Linux kernel that control the
> charging/discharging of the battery to provide better lifespan ?
> (add some years to its life ?)
> 
> For Laptops, it is better to extract the battery from the Laptop when
> the computer will be on power for a long period.
> I ask if the kernel can do such control without the user intention and
> in an automatic way.
> 
> Some BIOS provide to the user to select whether to block the battery
> charging to 50% to make it stand for more time.
> And Many people (like me) forget their laptops on power until the
> battery no more can hold energy after 2minutes of no power.
> 

On ThinkPads, tp_smapi (not in the kernel.org kernel) can do it.  I'd 
like to see this feature standardized in sysfs.

--Andy
