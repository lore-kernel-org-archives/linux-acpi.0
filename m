From: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Subject: Re: Acer TM636 won't wakeup after S3, USB, i8042
Date: Mon, 10 Jan 2005 21:12:55 -0500
Message-ID: <200501102112.55237.dtor_core@ameritech.net>
References: <20050111003537.13142400@bonenpikster.drs.p>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050111003537.13142400-aE6BZGIOaZ15NImTdOULw2AMOdFwdiat@public.gmane.org>
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
Cc: Tim Dijkstra <newsuser-TpnWJeB+oO0hKRfeEwdQzg@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Monday 10 January 2005 06:35 pm, Tim Dijkstra wrote:
> Hi,
> 
> Reading some positive reports on S3 on a travelmate 632, I gave it
> another try with my 636. After adding the acpi_sleep=s3_bios (thanks
> mizu) I got some visual signs of resume for the first time. But then
> the process halts. If I include USB support in the kernel, I get the
> following msgs
> 
> ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 11 (level,low) -> IRQ 11
> PCI: ENabeling device 0000:00:0b.0 (0080->0083)
> ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 10 (level,low) -> IRQ 10
> 
> And then it stops. Removing USB support gets me a bit further, now the process ends with:
> 
> i8042.c: Can't read CTR while initializing i8042.
> resume failed: i8042.c (Not sure about this line, typing it from memory)
>

Kernel attempts to resume keyboard controller but it is so dead that it's
not responding to even the basic command...
 
-- 
Dmitry


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
