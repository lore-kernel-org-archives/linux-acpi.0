From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: S3 freezes on wake on NC6000 laptop
Date: Mon, 7 Feb 2005 18:53:55 +0100
Message-ID: <20050207175354.GA20662@hell.org.pl>
References: <4207A416.8030400@colitti.com> <4207A8A2.1040202@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <4207A8A2.1040202-hi6Y0CQ0nG0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Cc: Lorenzo Colitti <lorenzo-Z4WAQ3j+MphBDgjK7y7TUQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Carl-Daniel Hailfinger:
> Ah, radeonfb. Please don't use radeonfb if you want to have any chance in
> resuming. Don't use any framebuffer on systems with radeon cards. It will
> freeze your machine completely. Actually, any graphics activity (framebuffer
> or X or svga access) will freeze it.

That's sort of incorrect, I've used radeonfb since late 2.5.X builds and I
don't remember it causing any problems resuming (of course, I need
acpi_sleep=s3_bios, but that's another thing). Radeonfb will resume just
fine, provided the underlying hardware is in a sane state. Granted, it may
cause freezes, but it's definitely not so that removing it will magically
cause your video to work or that it does always hang the machine.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
