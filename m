From: Chris Bennett <zortar-rdE3vRTOlSC6c6uEtOJ/EA@public.gmane.org>
Subject: Re: Re: S4bios support for 2.5.63
Date: Mon, 3 Mar 2003 18:12:24 +1030
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200303031812.25155.zortar@ihug.com.au>
References: <20030226211347.GA14903@elf.ucw.cz> <20030302202118.GA2201@outpost.ds9a.nl> <1046643757.3700.20.camel@irongate.swansea.linux.org.uk>
Reply-To: zortar-rdE3vRTOlSC6c6uEtOJ/EA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1046643757.3700.20.camel-MMxVpc8zpTQVh3rx8e9g/fyykp6/JSeS3vcXtXqGYxw@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Monday 03 March 2003 8:52 am, Alan Cox wrote:
> On Sun, 2003-03-02 at 20:21, bert hubert wrote:
> > On Mon, Mar 03, 2003 at 07:44:03AM +1300, Nigel Cunningham wrote:
> > > Hi.
> > >
> > > This bug is fixed in Linus tree. If you want swsusp to work in the mean
> > > time, look for a couple of patches Pavel sent recently.
> >
> > Ok,
> >
> > In 2.5.63bk5 I get a BUG on drivers/ide/ide-disk.c:1557:
> >
> >
> >         BUG_ON (HWGROUP(drive)->handler);
>
> Looks like swsuspend attempted to run an operation while one was in
> progress. IDE tries to catch that because the result of missing it isnt
> very pretty at fsck time.
>

Forgive me for my misunderstanding (i"m only new to acpi/kernel development), 
but if the problem is swsuspend running an operation while one is in 
progress, is there anyway way to pause the suspend process until all 
operations are done, so that IDE has nothing to catch....?

I have the same problem in 2.6.63 + acpi20030228 when entering S3, except it 
happens occasionally, not all the time.

Regards,

Chris Bennett


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
