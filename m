From: Matthew East <matthew.east-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: battery state on Compaq Presario
Date: Wed, 29 Dec 2004 11:11:36 +0000
Message-ID: <3bd911604122903114efc9b77@mail.gmail.com>
Reply-To: Matthew East <matthew.east-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi there,

Since 2.6.9 kernel I have experienced problems with the battery state
on my Compaq Presario 2104EA laptop. I have noticed the problem when
running the ubuntu 2.6.8.1 kernel, which I believe is patched with a
recent acpi release, and the gentoo-dev-sources 2.6.9. I just
installed a 2.4.26 kernel, and have found that it works perfectly.

The problems are quite complicated. Essentially when i boot with the
power adapter plugged in, acpid will give me the correct reading of
the battery. When there is a CHANGE of AC adapter state (i.e. i unplug
it), acpid does not give me the correct battery status, which remains
at the level which it was at. The same problem happens if I start the
computer without AC power, and plug it in: in this case the battery
status does not go down as it should.

Can anyone help me with this? I am fairly certain that it is a bug,
and the results when I tested it with the 2.4 kernel have convinced me
that this is not a hardware problem.

I thought that I would email this list before contacting the acpi maintainer.

I would be happy to provide any more information, and I hope i've been clear.

Many thanks in advance for your help.

Matt


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
