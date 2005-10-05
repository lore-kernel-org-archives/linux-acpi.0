From: "David Mathog" <mathog-Mlb+9xX7RBA8OKIjkCRLjtKIQNXEaThN@public.gmane.org>
Subject: Re: Save power at idle onTyan S2466N-MPX, athcool, etc.
Date: Wed, 05 Oct 2005 09:33:25 -0700
Message-ID: <E1ENCCr-0005rD-00@mendel.bio.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Erik Slagter <erik-KW7PGP3XNp7a5EbDDlwbIw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



> On Fri, 2005-09-30 at 15:36 -0700, David Mathog wrote:
> 
> > Flushed with success from that I next tried athcool
> > on a single processor (athlon-MP 2200+) Tyan 2466N-MPX
> > using a 2.6.8.1 kernel.  No joy. 

Erik Slagter replied:
> 
> We had a discussion about exactly this a few weeks ago.
> 
> It boils down to: the AMD768 chipset can do C1/C2/C3 but not out of the
> box using ACPI. First because ACPI processor support did not support
> multiprocessor, now it does, but the ACPI parameters of this motherboard
> prevent C2/C3 from being used by ACPI processor support.
> 
> So, out of the box you have C1, using the amd76x_pm you also have C2 and
> optionally C3 support (although that completely screws up my sata
> controller).

Got it, there are problems with ACPI and the S2466.  No big surprise
there since this board has all sorts of oddball problems.  (No WOL
etc.)

However, it sounded like you and others managed in the end
obtain some power savings at idle.  Correct?  If so,
could you or some other poster please explain how you accomplished
that, stating in particular:

1. relevant BIOS settings
2. minimum kernel required
3. any extra kernel patches required
4. any extra software (like athcool) required

The machines in question are single CPU beowulf nodes - they do
have an S3 video card but it is used only when there are
hardware problems and/or to change the BIOS.  So maybe
once every two years.  There's no sound, TV card, video streams,
or anything else like that.  These just sit around until a
compute job comes through, then they grind like crazy for a while.
It would be nice if they used less power while they were waiting.

Thanks,

David Mathog
mathog-7GExONQZ6ZKVc3sceRu5cw@public.gmane.org
Manager, Sequence Analysis Facility, Biology Division, Caltech


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
