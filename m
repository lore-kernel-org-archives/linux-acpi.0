From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: Re: [PATHC] Relaxed syntax for the processor PBLK length
Date: Mon, 31 Jan 2005 17:26:28 +0100
Message-ID: <20050131162628.GA4911@dominikbrodowski.de>
References: <41FD3E02.8010701@tremplin-utc.net> <20050131145836.GA1145@poupinou.org> <41FE4ABF.9040100@tremplin-utc.net> <20050131152931.GC1145@poupinou.org> <20050131155917.GA4416@dominikbrodowski.de> <41FE595D.5020605@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <41FE595D.5020605-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Eric Piel <Eric.Piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org>
Cc: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 31, 2005 at 05:14:21PM +0100, Eric Piel wrote:
> Dominik Brodowski a =E9crit :
> >
> >IIRC my desktop has a pblk of 5, and enabling _C2_ causes random locku=
ps.
> >
> >See also:
> >http://marc.theaimsgroup.com/?l=3Dacpi4linux&m=3D104570606821625&w=3D2
>=20
> Hummm, then I guess that my patch is not so welcome :-( Anyway, note=20
> that this patch allows a wrong PBLK length only if the syntax is=20
> relaxed. If your computer has a broken C2 state you could still force=20
> the strict syntax and it would boot.

However, Len's message indicates that I wasn't the only one who complaine=
d
:-(

	Dominik


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
