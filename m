From: Corentin CHARY <corentincj@iksaif.net>
Subject: Re: How to flash "Message LED" on Asus PC-DL via ACPI?
Date: Tue, 8 May 2007 18:14:36 +0200
Message-ID: <200705081814.36704.corentincj@iksaif.net>
References: <200705081020.33972.corentincj@iksaif.net> <32847781.1178582906744.JavaMail.ngmail@webmail14> <10028751.1178640321174.JavaMail.ngmail@webmail12>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:38975 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934593AbXEHQOj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 May 2007 12:14:39 -0400
In-Reply-To: <10028751.1178640321174.JavaMail.ngmail@webmail12>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: northy@arcor.de
Cc: linux-acpi@vger.kernel.org

> That is strange. I compiled acpi4asus-0.41, and this is the output when I
> try to modprobe asus-laptop: [root@shadow acpi4asus-0.41]# modprobe
> asus-laptop
> FATAL: Error inserting asus_laptop
> (/lib/modules/2.6.20-1.2948.fc6/acpi/asus-laptop.ko): No such device
# rmmod asus_acpi
# modprobe asus_laptop 
;)

and can you do that  ? :
# cat /proc/acpi/dsdt > /tmp/dsdt
and send me the dsdt ?

thanks


-- 
CHARY 'Iksaif' Corentin
http://xf.iksaif.net
