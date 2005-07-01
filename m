From: Andrew Haninger <ahaning-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: how to re-enable acpi
Date: Fri, 1 Jul 2005 09:24:37 -0400
Message-ID: <105c793f05070106247e4e8ce0@mail.gmail.com>
References: <20057119391.269331@p3200>
Reply-To: Andrew Haninger <ahaning-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20057119391.269331@p3200>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: mikel <mikel1-rdc5FV7LBygPGFelY5Zqew@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 7/1/05, mikel <mikel1-rdc5FV7LBygPGFelY5Zqew@public.gmane.org> wrote:
> the question is. If / Once we "disable" acpi via the "acpi=3Doff" option =
is
> there a way to re-enable it at a later point ?
Oddly enough, acpi=3Don (or acpi=3Dforce) should reenable ACPI.

If you mean "Can we reenable ACPI without rebooting?", I think the
answer is "no". I'll be glad if I'm wrong, though.

-Andy


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
