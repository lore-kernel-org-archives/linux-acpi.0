From: Len Brown <lenb@kernel.org>
Subject: Re: [-mm patch] make drivers/misc/thinkpad_acpi:fan_mutex static
Date: Sat, 28 Apr 2007 21:53:30 -0400
Message-ID: <200704282153.30858.lenb@kernel.org>
References: <20070425225716.8e9b28ca.akpm@linux-foundation.org> <20070428191938.GO3468@stusta.de> <20070428195821.GC2392@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753940AbXD2CFV@vger.kernel.org>
In-Reply-To: <20070428195821.GC2392@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


> > This patch makes the needlessly global fan_mutex static.

applied.
thanks,
-Len
