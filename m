From: Valette Eric <eric.valette-GANU6spQydw@public.gmane.org>
Subject: Re: Re: making progress with ACPI was: ACPI small patch up
 date
Date: Wed, 30 Oct 2002 10:01:50 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3DBF9FFE.4080806@free.fr>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A489@orsmsx119.jf.intel.com>
Reply-To: eric.valette-GANU6spQydw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>, Huw Hawkins <hrhawk-JGs/UdohzUI@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Grover, Andrew wrote:

>>I also complained about acpi patches beeing done for 2.4 pre releases 
>>and not applying cleanly on 2.4.X official kernels.
> 
> 
> If we have a prayer of ever getting into official 2.4, we need to track the
> pre kernels. People in the past have done backports to the non-pre kernels,
> but that really depends on what other people are willing to do.

But, if you complicate the task of applying acpi patches, on the other 
hand you get less tester. I already expressed that I apply other patches 
to the kernel I run and I do not have the patches for pre releases.

When I'm home like now, with an old 56K modem, I do not download a pre 
version for fun especially because, I have to apply the other patches I 
need to get my computer working as I want.

> We can fix bugs, the problem is *diagnosing* the issue. There's only so much
> diagnosis that can be done without the hardware. If you say "line 444 of
> ec.c is acquiring a semaphore at interrupt level" that's probably enough. If
> you post a patch, we'll apply it. If you just say "my system hangs" then
> it's a lot harder. Sometimes the dmesg or DSDT are enough that other people
> can suss out what might be the problem -- sometimes not.

Look, I posted on the mailling list the exact line of a problem leading 
to a system freeze (by the way it was deferrencing a null pointer) long 
time agao. Proposed a trivial fix that was working but
	1) you said it was a symptom not the problem. You were probably right 
but another version of acpi code was released without having the patch. 
As a result, ACPI lead to boot hang on any recent ASUS board.
	2) in order to diagnose something, yopu need to have a kernel to test

When I was working at Canon, downloading megabytes and testing was not a 
problem. I had a fast ethernet connection and plenty of PC. Now that is 
not anymore possible. Think about the guys who need ACPI but do not have:
	1) A fast internet connection,
	2) The knowledge to look at the rejected patch and apply the missing 
lines by hand,
	3) A system that does not work from scratch

Those guy will probably never test or will test once and if it fails, as 
they do not know if the bug is known and a fix exist, they will stop 
trying ACPI. This will obviously lead to testing far less system.

If you want to have ACPI in stable kernel before 2.6 :-), you need more 
tester, and a serious development policy. To me the project is in need 
of some kind of management.

> Part of this whole open source "gift" economy is that it's polite to not
> turn one's nose up a gift. Even if it wasn't all that you wanted. And
> especially if you haven't reciprocated.

Sorry but indeed I tried and reported several bug on DELL C600 and ASUS 
board. Look at the history. Now, because the development model makes it 
hard for me to:
	1) Follow the development,
	2) Know existing problem and possible solutions,
	3) Download patches that applying cleanly to my kernel,
	4) Post bug report that are effectively handled,

I do not invest too much time helping you despite I'm quite used to work 
with OSS, and have contributed to many OSS project including rtems 
<www.oarcorp.com>, goahed web server, debian linux distrib, ...

-- eric



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
