From: James D Strandboge <jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org>
Subject: Re: Repeatable lockup with sustained polling of battery
	state
Date: 06 Dec 2002 16:28:16 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1039210096.1878.12.camel@sirius.strandboge.cxm>
References: <1034266219.1287.40.camel@sirius.strandboge.cxm>
	 <1036013358.9704.93.camel@sirius.strandboge.cxm>
	 <1038339343.1840.4.camel@sirius.strandboge.cxm>
	 <20021129194032.GS1989@poup.poupinou.org>
	 <1038622526.515.2.camel@sirius.strandboge.cxm>
	 <20021202111335.GT1989@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021202111335.GT1989-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 2002-12-02 at 06:13, Ducrot Bruno wrote:
> Hi!
> 
> On Fri, Nov 29, 2002 at 09:15:27PM -0500, James D Strandboge wrote:
> > On Fri, 2002-11-29 at 14:40, Ducrot Bruno wrote:
> > > Could you please repost your dsdt?  I don't know what happen, but I can
> > > not disassemble it.  Could you also gzip it, please ?
> > > 
> > Thank you for responding.  Attached is my gzipped dsdt file.  I followed
> > the instructions on
> > http://www.intel.com/technology/iapc/acpi/bios_override.htm to get the
> > dsdt (ie 'cat /proc/acpi/dsdt > dsdt.dat').
> > 
> 
> I can now disassemble your DSDT.  Well, I suspected that your first
> post was somehow corrupted.  I seems that I was right..
> 
> I will take a look at it, but I can not promise something for you yet.
> 

I don't know if this is related, but I decided to see what kind of acpi
events my battery would generate if I let it run down completely.  As it
turns out, I got a few events, but they were all the same (ie 'received
event "battery BAT1 00000080 00000001"').  Here are the events from when
I unplugged the adapter until the battery went dead:


[Fri Dec  6 13:46:56 2002] received event "ac_adapter AC 00000080
00000000"
[Fri Dec  6 13:46:56 2002] executing action "/etc/acpi/ac.sh ac_adapter
AC 00000080 00000000"
[Fri Dec  6 13:46:56 2002] BEGIN HANDLER MESSAGES
[Fri Dec  6 13:46:56 2002] END HANDLER MESSAGES
[Fri Dec  6 13:46:56 2002] action exited with status 0
[Fri Dec  6 13:46:56 2002] executing action "/etc/acpi/default.sh
ac_adapter AC 00000080 00000000"
[Fri Dec  6 13:46:56 2002] BEGIN HANDLER MESSAGES
[Fri Dec  6 13:46:56 2002] END HANDLER MESSAGES
[Fri Dec  6 13:46:56 2002] action exited with status 0
[Fri Dec  6 13:46:56 2002] completed event "ac_adapter AC 00000080
00000000"
[Fri Dec  6 13:47:02 2002] received event "battery BAT1 00000080
00000001"
[Fri Dec  6 13:47:02 2002] executing action "/etc/acpi/default.sh
battery BAT1 00000080 00000001"
[Fri Dec  6 13:47:02 2002] BEGIN HANDLER MESSAGES
[Fri Dec  6 13:47:02 2002] END HANDLER MESSAGES
[Fri Dec  6 13:47:02 2002] action exited with status 0
[Fri Dec  6 13:47:02 2002] completed event "battery BAT1 00000080
00000001"
[Fri Dec  6 15:48:39 2002] received event "battery BAT1 00000080
00000001"
[Fri Dec  6 15:48:39 2002] executing action "/etc/acpi/default.sh
battery BAT1 00000080 00000001"
[Fri Dec  6 15:48:39 2002] BEGIN HANDLER MESSAGES
[Fri Dec  6 15:48:39 2002] END HANDLER MESSAGES
[Fri Dec  6 15:48:39 2002] action exited with status 0
[Fri Dec  6 15:48:39 2002] completed event "battery BAT1 00000080
00000001"
[Fri Dec  6 15:53:20 2002] received event "battery BAT1 00000080
00000001"
[Fri Dec  6 15:53:20 2002] executing action "/etc/acpi/default.sh
battery BAT1 00000080 00000001"
[Fri Dec  6 15:53:20 2002] BEGIN HANDLER MESSAGES
[Fri Dec  6 15:53:20 2002] END HANDLER MESSAGES
[Fri Dec  6 15:53:20 2002] action exited with status 0
[Fri Dec  6 15:53:20 2002] completed event "battery BAT1 00000080
00000001"

I am assuming that this is incorrect behavior.  Could this be related?

Jamie Strandboge

PS-- I disassembled my own dsdt and looked at it.  I do program in C and
other languages, but there were so few comments in there that I couldn't
really tell what was going on.  I was surprised to see this at the top
of the file though:

    Name (VERS, Package (0x03)
    {
        "Project: DELL Mojave", 
        "Date: 01/28/1998", 
        "Ver: 1.00.04"
    })

especially since the laptop was made 4 1/2 later than this date.

-- 
Email:        jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org
GPG/PGP ID:   26384A3A
Fingerprint:  D9FF DF4A 2D46 A353 A289  E8F5 AA75 DCBE 2638 4A3A




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
