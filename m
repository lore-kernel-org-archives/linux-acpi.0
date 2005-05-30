From: Fred Labrosse <ffl-4CLdheC3Iye1Qrn1Bg8BZw@public.gmane.org>
Subject: Re: ACPI and cooling fan control
Date: Mon, 30 May 2005 13:38:34 +0100
Message-ID: <20050530133834.67f7924e@localhost>
References: <429AFFA0.1090401@fcaglp.unlp.edu.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <429AFFA0.1090401-Sx9GWwsh3wButJw4YEhYoKkm5W21vHkk@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: zyserman-Sx9GWwsh3wButJw4YEhYoKkm5W21vHkk@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 30 May 2005 08:57:20 -0300
Fabio Zyserman <zyserman-Sx9GWwsh3wButJw4YEhYoKkm5W21vHkk@public.gmane.org> wrote:

> Hi folks, I am posting a new version
> of my previous message, which was
> ''Laptop powers off randomly''
> 
> Again, I have an A60 toshiba laptop,
> running kernel 2.6.10
> 
> I have experienced that it is not randomly,
> but when the fan stops (and then overheats, and
> powers off). The problem is
> 
> why does the fan stop randomly?!!!

This might be something else I reported a long time ago, that
disappeared in some version, but reappeared (at least in 2.6.11.10). 
The acpi modules (?) die when playing with cpufreq and governors.  This
has never really been solved, but disappeared in 2.6.10 (and has now
reappeared).  This was bug 3678.

Are you playing with cpufreq?

Fred


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
