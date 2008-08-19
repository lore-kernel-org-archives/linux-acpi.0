From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH v2 2/2] eeepc-laptop: Use standard interfaces
Date: Tue, 19 Aug 2008 20:09:50 -0300
Message-ID: <20080819230950.GC29336@khazad-dum.debian.net>
References: <20080804170833.GA9513@srcf.ucam.org> <20080806092352.GA17801@srcf.ucam.org> <20080806092523.GB17801@srcf.ucam.org> <20080819025815.b5ec1a4c.akpm@linux-foundation.org> <20080819111320.GA19223@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:41806 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753288AbYHSXKB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Aug 2008 19:10:01 -0400
Content-Disposition: inline
In-Reply-To: <20080819111320.GA19223@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, corentincj@iksaif.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Looks fine to me at first glance.  I do wonder if there are no events at all
you could hook to rfkill_force_state() instead of (or in addition to) using
the get_state()?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
