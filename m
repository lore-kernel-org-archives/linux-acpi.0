From: Pablo Bullian <pablo.bullian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Acer battery problem
Date: Wed, 10 Aug 2005 21:13:24 -0300
Message-ID: <14a648fa05081017135b27a38e@mail.gmail.com>
References: <14a648fa0508081102668fdd26@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <14a648fa0508081102668fdd26-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

no one can help me with that???

On 8/8/05, Pablo Bullian <pablo.bullian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi!, well I'm new here, and i have a problem i bought a Acer Aspire
> 3002LCi and I install a Mandrake or Mandriva 10.1, the thing is that
> my Xserver don't work if I use the laptop with the battery, it frezze
> when it start, and also my battery monitor doesn't work if i have the
> laptop plugged in, otherwise, like i said before it doesn't start X.
> when I put:
> # cat /proc/acpi/battery/BAT1/state
> present:                 yes
> ERROR: Unable to read battery status
>=20
> the info is:
> # cat /proc/acpi/battery/BAT1/info
> present:                 yes
> design capacity:         2000 mAh
> last full capacity:      1798 mAh
> battery technology:      rechargeable
> design voltage:          14800 mV
> design capacity warning: 200 mAh
> design capacity low:     71 mAh
> capacity granularity 1:  32 mAh
> capacity granularity 2:  32 mAh
> model number:            11ZL
> serial number:           3027
> battery type:            LION
> OEM info:                SIMPLO
>=20
> can someone help me? :(
>


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
