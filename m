From: Owen Cliffe <occ-sBK8fsN9CKk2EctHIo1CcQ@public.gmane.org>
Subject: Re: S3 works on Dell i2650, but no display
Date: 28 May 2003 13:25:00 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1054121096.4168.72.camel@noodle>
References: <20030524155445.GA262@elf.ucw.cz>
	 <Pine.LNX.4.33.0305280221440.20262-100000@godzilla.se.axis.com>
	 <20030528111100.GA342@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030528111100.GA342-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

The same behaviour manifests itself on the Dell lattitude D600, as far
as I can see the only common components of the i2650 and the D600
machines are the dell bioses, the graphics chipsets are different (2650
has Geforce2 D600 has a radeon 9000) 

this could just be a coincidence...

With DSDTs there seem to be very few differences between the p4
notebooks and the centroni ones, and they have of course  exhibited the
same bugs. 

owen 

On Wed, 2003-05-28 at 13:11, Pavel Machek wrote:
> Hi!
> 
> > > > When I tried to resume however, I found that the console display
> > > >didn't come back on - though I knew the machine was responsive because
> > > >I could type commands
> > 
> > > You might need to get datasheet to your videocard and write specific
> > > support. Also try lspci before and after suspend etc. [But don't
> > > expect this to be easy].
> > 
> > Isn't this a general problem on all notebooks - even if you know everything 
> > about the videocard used, might not the notebook use a completely different 
> > mechanism for actually turning on and off the display (with
> >backlight etc) ?
> 
> Okay, so you need videocard datasheet *and* notebook datasheet :-((((.
> 
> > I remember we had a similar discussion a while ago when I tried to get S3 
> > working on my Acer notebook and the only way to enable that backlight was 
> > through the bios lcall. Then 2.5.69 came, S3 broke again on the Acer, and I 
> > haven't tested anything more :) 
> 
> Can you find out what patch exactly killed it?
> 
> > What is done in the other notebooks that actually have S3 working - do their 
> > screens default to backlight-on when the hardware gets powered on, do they 
> > use the lcall, or is there some other magic possible ? Can we systematically 
> > solve that proble I mean ?
> 
> On HP omnibook, video is in state (pretty much exactly) it was after
> S3. On toshiba, it is in text-mode vga with backlight on. On "hobit"
> it needs lcall to initialize it through bios.
> 								Pavel
-- 
---------------------------------------------------------------------
owen cliffe (postgraduate)          Email: occ-sBK8fsN9CKk2EctHIo1CcQ@public.gmane.org
Department of Computer Science        Web: http://www.cs.bath.ac.uk/~occ
Univ. Bath, Bath, England BA2 7AY      Tel: (+44) 1225 386183





-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
