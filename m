From: Nick Lidakis <nlidakis-H+0wwilmMs3R7s880joybQ@public.gmane.org>
Subject: Re: Desktop and S3 suspend the Holy Grail of ACPI?
Date: Sat, 28 Feb 2004 16:38:49 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40410A69.3070800@verizon.net>
References: <4038F499.2060302@verizon.net> <20040225182030.GG1214@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040225182030.GG1214-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Pavel Machek wrote:

>Hi!
>
>  
>
>>I am new to ACPI but I have searched the archives, looked at the MAN 
>>pages used Google to the best of
>>my abilities and I still have some questions about ACPI. My basic goal 
>>is to be able
>>to suspend my desktop machine to S3 when not in use. I need to use the
>>machine several times throughout the day, and feel it is a waste to leave
>>it on continuously. The system spec are: Intel D875PBZ, Intel P4 3GHZ,
>>Radeonm 9700 pro, Sounblaster Live, Debian unstable with 2.4.23 and
>>2.6.2 kernels available, both with ACPI compiled as modules. Pressing
>>the power button once gracefully shuts down the machine running either 
>>kernel.
>>    
>>
>
>Try getting suspend-to-disk working, first.
>								Pavel
>  
>
I am assuming your terse response is meant to imply that swsusp would be 
a better alternative to S3?

I tried playing with suspend to disk in kernel 2.6.3. It was a no go. I 
have highmem enabled on this machine which has 1 gig of RAM.
Going to try pmdisk.


Nick


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
