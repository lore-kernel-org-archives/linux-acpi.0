From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] sony-laptop: allow complex per-value input/output validation
Date: Tue, 13 Feb 2007 10:16:59 -0200
Message-ID: <20070213121659.GA25171@khazad-dum.debian.net>
References: <20070212210107.GA5577@inferi.kami.home> <200702122355.56336.lenb@kernel.org> <49660.85.47.20.193.1171356477.squirrel@picard.linux.it> <1171357148.6028.5.camel@localhost.localdomain> <50157.85.47.20.193.1171358948.squirrel@picard.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:48162 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751303AbXBMMRM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 Feb 2007 07:17:12 -0500
Received: from out1.internal (unknown [10.202.2.149])
	by out1.messagingengine.com (Postfix) with ESMTP id B415A1AF092
	for <linux-acpi@vger.kernel.org>; Tue, 13 Feb 2007 07:17:09 -0500 (EST)
Received: from khazad-dum.debian.net (unknown [201.82.24.150])
	by mail.messagingengine.com (Postfix) with ESMTP id 4B93FED39
	for <linux-acpi@vger.kernel.org>; Tue, 13 Feb 2007 07:17:09 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by localhost.khazad-dum.debian.net (Postfix) with ESMTP id 2F1E32806D
	for <linux-acpi@vger.kernel.org>; Tue, 13 Feb 2007 10:17:02 -0200 (BRST)
Received: from khazad-dum.debian.net ([127.0.0.1])
	by localhost (khazad-dum.debian.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id WqzZNMyyI+ZO for <linux-acpi@vger.kernel.org>;
	Tue, 13 Feb 2007 10:16:59 -0200 (BRST)
Content-Disposition: inline
In-Reply-To: <50157.85.47.20.193.1171358948.squirrel@picard.linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Tue, 13 Feb 2007, Mattia Dongili wrote:
> well this is actually hardware driven, the brightness_default in
> sony-laptop only exposes a DSDT method to set this value.
> So it's actually one more feature, not a software trick :)
> I admit the attribute could be better named 'poweron_brightness'.

ThinkPads can also do this, if we keep their CMOS up-to-date (which we do,
currently).  The solution taken by ibm-acpi is to set the power-on
brightness at every brighness change, so the machine powers up in the last
state it was left in.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
