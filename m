From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: system freezes for 0.2 to 0.5 seconds when reading
 /proc/acpi/thermal_zone/THRM/temperature
Date: Wed, 27 Jul 2005 16:16:05 -0700
Message-ID: <20050727161605.5711fcf7.akpm@osdl.org>
References: <20050728002244.5163ac4a@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050728002244.5163ac4a@localhost>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Florian Engelhardt <flo-MALAOO1t6vMdnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Florian Engelhardt <flo-MALAOO1t6vMdnm+yROfE0A@public.gmane.org> wrote:
>
> Hello,
> 
> first of all, sorry for the long headline.
> second:
> Every time, i try to do the following:
> cat /proc/acpi/thermal_zone/THRM/temperature
> the whole system looks up for a short period of time (something about
> 0.5s). realy everything, video and audio encoding, mouse and keyboard
> input, firefox playing a flash animation, ...
> I am also getting the following:
> Losing some ticks... checking if CPU frequency changed.
> 
> maybe these two things are belonging to each other.
> 
> I am using a 2.6.12-rc3-mm1 kernel on a amd64 with a nvidia nforce4
> mainboard.

It might help if you were to generate a kernel profile:

readprofile -r
for i in $(seq 10)
do
	cat /proc/acpi/thermal_zone/THRM/temperature
done
readprofile -n -v -m /boot/System.map | sort -n +2 | tail -40



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
