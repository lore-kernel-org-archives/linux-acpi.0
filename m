From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Change spinlock mutex to semaphor in ec.c
Date: Fri, 4 Feb 2005 08:53:40 -0500
Message-ID: <d120d50005020405534e49dad3@mail.gmail.com>
References: <3ACA40606221794F80A5670F0AF15F84041AC120@pdsmsx403>
	 <200502040150.25175.dtor_core@ameritech.net>
	 <42036527.4030807@bartol.udel.edu>
Reply-To: dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <42036527.4030807-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Cc: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 04 Feb 2005 07:05:59 -0500, Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org> wrote:
> Dmitry Torokhov wrote:
> > On Friday 04 February 2005 01:31, Yu, Luming wrote:
> >
> >>I have patch set for this issue filed at
> >> http://bugzilla.kernel.org/show_bug.cgi?id=3851#c28 .
> >>
> >>The first patch is from you.
> >>
> >
> >
> > Oh, I see... this is a newer version though, simplified a bit (I think).
> >
> 
> Hi Dmitry & Luming --
> 
> I'm glad to see that better minds than mine have been working on this
> problem!
> 
> However, I can't get either of the patches on the above Bugzilla page to
> apply cleanly to 2.6.10. Are there any up-to-date versions of the patch?
> 

The patch I sent in e-mail is against post 2.6.11-rc2 pull from Linus
tree. Not sure if it will apply to 2.6.10 though.

-- 
Dmitry


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
