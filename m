From: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Subject: Re: keylock regression with i8042 + S3 resume
Date: Mon, 15 Nov 2004 09:58:25 -0500
Message-ID: <4198C411.4070705@optonline.net>
References: <88056F38E9E48644A0F562A38C64FB600356939A@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <88056F38E9E48644A0F562A38C64FB600356939A-exJ48ZlmiLpQxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Pallipadi, Venkatesh wrote:

>I had some problem with S3 resume and keyboard and I nailed down to this
>changeset
>
>http://linux.bkbits.net:8080/linux-2.6/cset@40fc9c34Uv8lvE8IkEDy5dqjDzb_
>Kw?nav=index.html|src/.|src/drivers|src/drivers/input|src/drivers/input/
>serio|related/drivers/input/serio/i8042.c 
>
>But, it was not a consistent failure and I only saw it once in a while.
>
>HTH,
>Venki
>
For me, it's pretty consistent. Will work on Dmitry's debug options later.
Nathan



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
