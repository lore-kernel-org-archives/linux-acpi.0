From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: keylock regression with i8042 + S3 resume
Date: Mon, 15 Nov 2004 09:11:09 -0500
Message-ID: <d120d50004111506116f9c2f3f@mail.gmail.com>
References: <4197F388.2050701@optonline.net>
Reply-To: dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4197F388.2050701-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, 14 Nov 2004 19:08:40 -0500, Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org> wrote:
> Hi,
> 
> Ever since upgrading from a 2.6.9-rc1 era bitkeeper snapshot to a
> 2.6.10-rc1 era snapshot, the keyboard is nonfunctional after resume from
> S3 and the kernel prints this message on resume:
> i8042.c: Warning: Keylock active.
> 
> Anybody know anything about this?
> 

HI,

Could you change #undef DEBUG into #define DEBUG in
drivers/input/serio/i8042.c, recompile and reboot passing
log_buf_len=131072 option to the kernel. Then suspend,
resume and save full dmesg somewhere and send it to me.

Thanks! 

-- 
Dmitry


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
