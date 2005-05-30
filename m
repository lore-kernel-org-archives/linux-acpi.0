From: Fabio Zyserman <zyserman-Sx9GWwsh3wButJw4YEhYoKkm5W21vHkk@public.gmane.org>
Subject: ACPI and cooling fan control
Date: Mon, 30 May 2005 08:57:20 -0300
Message-ID: <429AFFA0.1090401@fcaglp.unlp.edu.ar>
Reply-To: zyserman-Sx9GWwsh3wButJw4YEhYoKkm5W21vHkk@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Hi folks, I am posting a new version
of my previous message, which was
''Laptop powers off randomly''

Again, I have an A60 toshiba laptop,
running kernel 2.6.10

I have experienced that it is not randomly,
but when the fan stops (and then overheats, and
powers off). The problem is

why does the fan stop randomly?!!!

If I boot with the option
acpi=off
the fan works ok, i.e., it works harder
when the processor is compiling some package,
for example.

May be there is some problem with acpi controlling the fan?

Any hint will be welcomed, I would like not to have to
disable acpi.

Regards,

Fabio Zyserman


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
