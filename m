From: =?iso-8859-1?q?J=F6rg=20Sonnenberger?= <joerg.sonnenberger-S0/GAf8tV78@public.gmane.org>
Subject: Re: Tablet PC + 2.4.18 + acpi 20020726 + swsup11 working !
Date: Tue, 6 Aug 2002 16:30:32 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200208061630.32814.joerg.sonnenberger@web.de>
References: <3D4F7B2A.2090602@symplon.com> <20020806140043.GB16571@poup.poupinou.org> <3D4FDE0B.4020600@symplon.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3D4FDE0B.4020600-y2s3ugBAdl9BDgjK7y7TUQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Robert =?iso-8859-1?q?W=F6rle?= <robert.woerle-y2s3ugBAdl9BDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Am Dienstag, 6. August 2002 16:32 schrieb Robert W=F6rle:
> Tell me guys , what driver is this pic2 .. where can i found the
> according **.c to have some try`S and modify it
> so if it doesnt need these ports then i can use them for my purposes ..=
=2E

The code (initialization at least) is in arch/i386/kernel/i8259.c

J=F6rg


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
