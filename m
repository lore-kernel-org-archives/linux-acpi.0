From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: How do I do an acpidump
Date: Sat, 16 Aug 2008 11:27:21 +0100
Message-ID: <48A6AB89.1010005@tuffmail.co.uk>
References: <200808151841.22788.c_lauire@mypostoffice.co.uk> <48A5D783.2050007@tuffmail.co.uk> <200808161054.35925.c_lauire@mypostoffice.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:36805 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605AbYHPK1Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Aug 2008 06:27:25 -0400
Received: by nf-out-0910.google.com with SMTP id d3so860418nfc.21
        for <linux-acpi@vger.kernel.org>; Sat, 16 Aug 2008 03:27:24 -0700 (PDT)
In-Reply-To: <200808161054.35925.c_lauire@mypostoffice.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Colin Laurie <c_lauire@mypostoffice.co.uk>
Cc: linux-acpi@vger.kernel.org

Colin Laurie wrote:
> Thank you for that.
> Unfortunately I already have pmtools for 64 bit Suse linux KDE4.
> I cannot currently find a way to run programs unless they are in the applications menu, other than 
> from my bash terminal.
> The latter does not recognise any acpid__ commands or have any man pages for them.
>
> Apologies if I am displaying my ignorance but there is no guidance whatsoever in this matter, that I 
> can find.
>   
<http://www.lesswatts.org/projects/acpi/utilities.php>

    In summary, dump the ACPI tables from your system to a text file:
    $ acpidump > acpidump.out

Perhaps you need to start a root shell using the "su" command, before
you try running the "acpidump" command.  acpidump likely lives under
/usr/sbin which is not in the search path for normal users (and it
should need root privileges anyway).

This might be considered a UI flaw in SUSE.  In Ubuntu you would be able
to run "acpidump" as a normal user, and then guess that root was
required if it complains "permission denied".

Alan
