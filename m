From: Stefan Schweizer <sschweizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Samsung P35, S3, black screen (radeon)
Date: Thu, 3 Feb 2005 06:38:38 +0100
Message-ID: <e796392205020221387d4d8562@mail.gmail.com>
References: <20050122134205.GA9354@wsc-gmbh.de> <4201825B.2090703@gmx.net>
Reply-To: Stefan Schweizer <sschweizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <4201825B.2090703-hi6Y0CQ0nG0@public.gmane.org>
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
Cc: Nikolaus Filus <nfilus-hi6Y0CQ0nG0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 03 Feb 2005 02:46:03 +0100, Carl-Daniel Hailfinger
<c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org> wrote:
> Please try latest 2.6.11-rc2-bkX and NO additional patches. Make sure you
> don't compile in radeonfb or atyfb. Vesafb doesn't matter. Xorg version
> is irrelevant.
> Kernel commandline should contain
> video=vesa:off
> and no other video parameters.

Are you able to use framebuffer(radeonfb,1024x768) with this
configuration or do you need to use plain vga-console for it to work?

mfg,
Stefan


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
