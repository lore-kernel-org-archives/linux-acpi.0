From: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Subject: Re: DockApps
Date: Fri, 21 Jan 2005 13:57:05 +0100
Message-ID: <m2hdlb7xem.fsf@phoenix.squirrel.nl>
References: <16880.8771.253591.739342@phoenix.squirrel.nl>
	<20050121101018.GB3945@himi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050121101018.GB3945-Ji7FXtOmRLs@public.gmane.org> (Simon Fowler's message of
 "Fri, 21 Jan 2005 21:10:18 +1100")
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

simon-Ji7FXtOmRLs@public.gmane.org (Simon Fowler) writes:

>> wmacpi is quite nice (needs a couple of patches, though).
>
> If you're talking about wmacpi 2, what patches do you need?

I was talking 1.34, and didn't know you took over maintenance until I
read your previous mail.

The patches required for 1.34 concern the selection of batteries (on
my --and other-- systems it selects the second (absent) battery) and
adding a -geometry command line option (I run the dockapps as
individual programs, w/o suitable window manager). I also corrected
some of the colours in the pixmap (so you can change the colour of the
LCD segments in one edit).

> If not, try hitting http://himi.org/wmacpi/ and trying it out - it
> should work fine on any modern system (as long as the
> /proc/acpi/battery/ interface is there

I did, and I can't get it to work at all. I get an empty, zero-sized
window. Could be my lack of suitable window manager, though.

libdockapp 1.50 seems to be read protected, so I couldn't test the 2.1
RC.

> - if I can get some docs on the new SBS interface
> I'll gladly add code for handling it, though I can't test it
> myself).

I'll send you (via private e-mail, please do not ignore it ;-)) the
detailed output of all associated /proc/files. I hope this helps.

-- Johan



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
