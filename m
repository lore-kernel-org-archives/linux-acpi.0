From: Bjorn Wesen <bjorn.wesen-VrBV9hrLPhE@public.gmane.org>
Subject: Re: S3 causes hang on Dell I2650 in 2.5.60
Date: Tue, 18 Feb 2003 00:46:26 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.33.0302180043080.21776-100000@godzilla.axis.se>
References: <3E5180A6.8090607@ihug.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3E5180A6.8090607-rdE3vRTOlSC6c6uEtOJ/EA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Luke Hammer <lukeh-rdE3vRTOlSC6c6uEtOJ/EA@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 18 Feb 2003, Luke Hammer wrote:
> done on the 2.5.x kernel, I compiled the 2.5.60 kernel on
> my Dell Inspiron 2650 laptop and tried to enter the S3
> suspend state (with 'echo 3 >/proc/acpi/sleep'). All that
> happened was that I got the words 'Stopping tasks:' on
> the console and the laptop hung. There doesn't seem to
> be anything in the logs about it. Does anyone know what's
> happening here?

Try compiling a minimal kernel without any drivers, scsi emulation etc in 
it (well except for the necessary, perhaps like IDE and keyboard and stuff 
:) and try again. Some kernel threads and drivers will hang the freezing of 
the processes upon sleep. You can add debug printouts in the refridgerator 
code (don't have the filename right now..) so you see which tasks are 
stopping when it hangs. Adding other debug printouts are useful as well 
(there should really be some more permanent printouts in that code..)

The drivers I needed but are buggy are 8139too.c and the scsi emulation 
(trivial fixes to make them work though).

/Bjorn



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
