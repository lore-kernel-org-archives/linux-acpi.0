From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: ACPI problem
Date: Fri, 07 Oct 2005 13:00:53 +0200
Message-ID: <43465565.7020804@suse.de>
References: <3ebbb09c0510061554h5c19610al9d0ecfabf9707312@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ebbb09c0510061554h5c19610al9d0ecfabf9707312-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Giacomo Rizzo <giacomorizzo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Giacomo Rizzo wrote:
> Hi,
> Len Brown gave me your address because I talked to him
> about a problem I'm having while trying installing linux (I tried
> several distros)
> The problem is that my notebook (a sony pcg-nvr23)
> shuts down after a random number of seconds during the installation process.
> I think it's an acpi problem because once I tried booting Knoppix by keeping
> the temperature around
Ohh, at installation process.
The machine probably needs processor, thermal and fan module to be loaded to 
control your fans which will be loaded after the right package is installed -> 
too late.

I wonder why you could install SL 9.1 as we started to load these modules very 
early with 9.3/10.0.

Maybe it's even a more general ACPI regression that prevents your fan controlled 
  properly? Is there time enough to catch dmesg output?

     Thomas


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
