From: Troels Haugboelle <troels_h-dnJlcM5dL/Zknbxzx/v8hQ@public.gmane.org>
Subject: Re: Re: S4bios support for 2.5.63
Date: 03 Mar 2003 15:07:54 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1046700474.3782.197.camel@localhost>
References: <20030226211347.GA14903@elf.ucw.cz>
	 <20030302133138.GA27031@outpost.ds9a.nl>
	 <1046630641.3610.13.camel@laptop-linux.cunninghams>
	 <20030302202118.GA2201@outpost.ds9a.nl>
	 <20030303003940.GA13036@k3.hellgate.ch>
	 <1046657290.8668.33.camel@laptop-linux.cunninghams>
	 <20030303113153.GA18563@outpost.ds9a.nl>
	 <20030303122325.GA20929@atrey.karlin.mff.cuni.cz>
	 <20030303123551.GA19859@outpost.ds9a.nl>
	 <20030303124133.GH20929@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="=-XdAu9q69IfBpgnuZ8Ewn"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030303124133.GH20929-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: troels_h-dnJlcM5dL/Zknbxzx/v8hQ@public.gmane.org, bert hubert <ahu-yMKkj5jtC+M@public.gmane.org>, Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>, Roger Luethi <rl-7uj+XXdSDtwfv37vnLkPlQ@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-XdAu9q69IfBpgnuZ8Ewn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

just to add my experience. Maybe it helps. I haven't been able to get
swsusp working on any 2.4.x kernel until i did an
    hdparm -u1 /dev/hda
now the strange thing: I tried to turn on the frame buffer device and
it started chrashing again until i did
    hdparm -u0 /dev/hda
Before I tried using suspend in 2.5.x with varying success. Now
everything runs like a charm. Without unmask irq's first the kernel
dumped
with either a kernel BUG statement or a fault in ide-disk.c

hope it helps, regards

Troels Haugboelle

PS. I am running on fujitsu lifebook P4-M laptop with reiserfs and intel
845 chipset.
I have only one hard disk too.

On Mon, 2003-03-03 at 13:41, Pavel Machek wrote:

> Hi!
> 
> > [ pruned mr Grover from the CC list ]
> > 
> > On Mon, Mar 03, 2003 at 01:23:25PM +0100, Pavel Machek wrote:
> > > Well, it does not happen on my machines, but I've already seen it
> > > happen on computer with two harddrives.
> > 
> > This is a laptop with only one. Anything I can do to help, let me know. Alan
> > has suggested that an IDE transaction was still in progress, perhaps a small
> > wait could prove/disprove this assumption?
> 
> Start adding printks to see whats going on. Try going ext2. Try
> killing sys_sync() from kernel/suspend.c.
> 
> 									Pavel

--=-XdAu9q69IfBpgnuZ8Ewn
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/1.1.7">
</HEAD>
<BODY>
Hi,<BR>
<BR>
just to add my experience. Maybe it helps. I haven't been able to get<BR>
swsusp working on any 2.4.x kernel until i did an<BR>
&nbsp;&nbsp;&nbsp; hdparm -u1 /dev/hda<BR>
now the strange thing: I tried to turn on the frame buffer device and<BR>
it started chrashing again until i did<BR>
&nbsp;&nbsp;&nbsp; hdparm -u0 /dev/hda<BR>
Before I tried using suspend in 2.5.x with varying success. Now<BR>
everything runs like a charm. Without unmask irq's first the kernel dumped<BR>
with either a kernel BUG statement or a fault in ide-disk.c<BR>
<BR>
hope it helps, regards<BR>
<BR>
Troels Haugboelle<BR>
<BR>
PS. I am running on fujitsu lifebook P4-M laptop with reiserfs and intel 845 chipset.<BR>
I have only one hard disk too.<BR>
<BR>
On Mon, 2003-03-03 at 13:41, Pavel Machek wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE><FONT COLOR="#737373" SIZE="3"><I>Hi!

&gt; [ pruned mr Grover from the CC list ]
&gt; 
&gt; On Mon, Mar 03, 2003 at 01:23:25PM +0100, Pavel Machek wrote:
&gt; &gt; Well, it does not happen on my machines, but I've already seen it
&gt; &gt; happen on computer with two harddrives.
&gt; 
&gt; This is a laptop with only one. Anything I can do to help, let me know. Alan
&gt; has suggested that an IDE transaction was still in progress, perhaps a small
&gt; wait could prove/disprove this assumption?

Start adding printks to see whats going on. Try going ext2. Try
killing sys_sync() from kernel/suspend.c.

									Pavel</I></FONT></PRE>
</BLOCKQUOTE>
</BODY>
</HTML>

--=-XdAu9q69IfBpgnuZ8Ewn--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
