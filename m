From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Working around bugs in ACPI BIOS [was Re: DSDT in initrd]
Date: Mon, 19 May 2003 17:17:27 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030519151727.GK346@poupinou.org>
References: <F760B14C9561B941B89469F59BA3A847E96EA0@orsmsx401.jf.intel.com> <20030518213405.GB452@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030518213405.GB452-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Randy.Dunlap" <rddunlap-3NddpPZAyC0@public.gmane.org>, mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, May 18, 2003 at 11:34:05PM +0200, Pavel Machek wrote:
> Hi!
> 
> > I must admit I'm really torn. If there were 2-3 little AML problems that
> > if we worked around them, a horde of machines would start working, then
> > I think we would do that, but my sense is that there are many more ways
> > a DSDT can be broken, and that implementing workarounds for all of them
> > would cause other systems to fail. Maybe some of the people who have
> > fixed their DSDTs can comment on the scope of bugs out there.
> 
> I believe policy should be "if it can't possibly break anyone".
> 
> AML functions not returning value can be safely replaced with
> returning 0; uninitialized variables can also be initialized with
> 0. Both should be safe, and we should printk() loudly in both cases.
> 

o relax operational region checking (not so trivial as it sound like,
  and may be done at acpi init stage imho),
o Store(Local0, Local0) is a Noop,
o allow return statements to be propageted to the calling method if the
  caller is known to return 'something' (either because it is a reserved
  method known to return something, or because it return
  something in other code path),
o mutex mis-use.

others?

All of them could be a separate kernel options, and cry when
possible (not handled by acpi debug option).

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
