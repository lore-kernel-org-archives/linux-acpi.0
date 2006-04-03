From: Francesco Biscani <biscani@pd.astro.it>
Subject: Re: ACPI Error (Method parse/execution failed) with 2.6.16 kernel
Date: Mon, 3 Apr 2006 14:09:46 +0200
Message-ID: <200604031409.47274.biscani@pd.astro.it>
References: <c87e555d0603311120n52e78493u610de7a8474e65d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vsmtp12.tin.it ([212.216.176.206]:54956 "EHLO vsmtp12.tin.it")
	by vger.kernel.org with ESMTP id S1750710AbWDCMKN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Apr 2006 08:10:13 -0400
In-Reply-To: <c87e555d0603311120n52e78493u610de7a8474e65d3@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maurizio Lombardi <m.lombardi85@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Friday 31 March 2006 21:20, Maurizio Lombardi wrote:
> Hi,
>
> I had some problems switching from 2.6.15.6 to 2.6.16 kernel version.
> At boot sometimes i get some errors about ACPI, you can find logs as
> attachment. As a result, sometimes my laptop is unable to read batter=
y
> remaining capacity level.
>
> Do you know how to fix this problem?

=46YI I had ACPI-related issues too when upgrading to 2.6.16 from 2.6.1=
5. Your=20
error messages seem similar to mine, for which I've opened a bugreport =
here

http://bugzilla.kernel.org/show_bug.cgi?id=3D6278

Maybe together we can make some more noise ;)

  Francesco

--=20
Dr. Francesco Biscani
Dipartimento di Astronomia
Universit=E0 di Padova
biscani@pd.astro.it
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
