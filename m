From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Help needed to fix my dsdt / running out of ideas
Date: Fri, 4 Nov 2005 09:27:28 +0800
Message-ID: <59D45D057E9702469E5775CBB56411F1C70BC3@pdsmsx406>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Maximilian Mehnert <widolo87-LWAfsSFWpa4@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
>
>I have fixed a few dsdts before so I am not completely new to this.
>
>However I have no clue how to fix my current dsdt after it changed
>because of a RAM upgrade.
>
>Attached to this mail you find my decompiled dsdt and the output of
iasl
>trying to compile it again.
>
>I would be extremely glad if someone with more insight into this matter
>could give me a few advises to fix the first (and maybe the last)
error.
>Most of them seem to follow the same pattern so I should be able to do
>most of this on my own...
>
nsaccess-0534: *** Error: ACPI path has too many parent prefixes (^) -
reached beyond root node

^ stands parent. Maybe you could use absolute path for the node. Such as
you can change 'Scope (^^PCI0)' to 'Scope (_SB.PCI0)'.

Thanks,
Shaohua


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
