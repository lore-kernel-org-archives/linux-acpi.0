From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Re: [Acpi4asus-user] DSDT table for Asus L5F00GA
Date: Tue, 8 Jun 2004 15:33:56 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040608133356.GQ13782@poupinou.org>
References: <40C23B64.4070603@viktoria-poland.com.pl> <20040607212832.GA16077@hell.org.pl> <40C4E25A.8000004@viktoria-poland.com.pl> <40C4E2FC.3060502@viktoria-poland.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <40C4E2FC.3060502-SwppDJA1QMU+Zj8wmS2FlIcoqjos4MI6@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Rafa? <lista-SwppDJA1QMU+Zj8wmS2FlIcoqjos4MI6@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jun 07, 2004 at 11:49:48PM +0200, Rafa? wrote:
> User Karol Kozimor wrote:
> 
> > Thus wrote Rafa?:
> >
> >> Hello
> >>
> >> I'm using Asus L5F00GA notebook. I checked if the DSDT table is 
> corect, as shown on http://forums.gentoo.org/viewtopic.php?t=122145 
> site. Well, it is not correct. When I try to compile table using iasl 
> compiler, I get the following error:
> >>
> >> Intel ACPI Component Architecture
> >> ASL Optimizing Compiler / AML Disassembler version 20040527 [Jun  4 
> 2004]
> >> Copyright (C) 2000 - 2004 Intel Corporation
> >> Supports ACPI Specification Revision 2.0c
> >>
> >> dsdt.dsl  7416:     If (SS1)
> >> Error    1037 -      ^ syntax error, unexpected PARSEOP_IF
> >
> >
> >
> > Please supply your DSDT, or (even better) post it to acpi.sf.net.
> > The error is, on the other hand, quite common, you should be safe by
> > removing the If statements (i.e. unconditionally leaving the 
> definitions).
> 
> 
> The tables are here:
> 
> http://wujek.kolko-rozancowe.org/dsdt.dsl
> 
> I took them with the following command:
> 
> cat /proc/acpi/dsdt > /dsdt
> and then:
> iasl -d /dsdt
> 
> I'm not sure if this is what you meant. If you wanted not disassembled 
> tables then they are here:
> 
> http://wujek.kolko-rozancowe.org/dsdt
> 
> I removed those IF statements in dsdt.dsl file and the compile errors 
> disappeared but there were still warnings. I've put those tables
> somehow into the kernel (I modified the osl.c file as shown in some 
> tutorials). Kernel compiled succesfully, it booted with no
> problems and there were less "method execution failed" messages. 
> However, the sleep states still don't work, making
> echo 3 > /proc/acpi/sleep does not work at all, nothing happens and no 
> error messages are displayed. I have no idea how to make it work
> and get rid off all those error messages during bootup :(
> 

As I read your dsdt.dsl, S3 is probably a bios option.  It's something
you can verify at BIOS prompt perhaps.  If not, after looking the AML,
this little program should help you to determine if S3 is off.

--- CUT ---
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>

#include <sys/stat.h>
#include <sys/types.h>


int main()
{
	int fd;
	char val;

	fd = open("/dev/mem", O_RDONLY);
	if (fd < 0) {
		perror("open");
		exit(1);
	}

	if (lseek(fd, 0x1ffdf064, SEEK_SET) == (off_t)-1) {
		perror("lseek");
		exit(1);
	}

	if (read(fd, &val, 1) != 1) {
		perror("read");
		exit(1);
	}

	printf("S1 %s\nS2 %s\nS3 %s\nS4 %s\n",
		val & 1 ? "yes" : "no",
		val & 2 ? "yes" : "no",
		val & 4 ? "yes" : "no",
		val & 8 ? "yes" : "no");

	return 0;
}
--- CUT ---

This correspond to this portion of the ASL:

    OperationRegion (BIOS, SystemMemory, 0x1FFDF064, 0xFF)
    Field (BIOS, ByteAcc, NoLock, Preserve)
    {
        SS1,    1,
        SS2,    1,
        SS3,    1,
        SS4,    1,

        ...
        ...
        ...
    }


Note that even if S3 is supported from firmware point-of-view, this is still in
developpement at that time under Linux..

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
