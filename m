From: "Renato S. Yamane" <renatoyamane@mandic.com.br>
Subject: Re: Add INPUT support to toshiba_acpi
Date: Mon, 11 Jun 2007 10:26:42 -0300
Message-ID: <466D4D92.4040102@mandic.com.br>
References: <1180614979.2693.26.camel@localhost.localdomain>	 <1180788652.2355.27.camel@localhost.localdomain>	 <20070602142333.GA3452@srcf.ucam.org>	 <200706030048.40393.dtor@insightbb.com> <1181235539.2610.72.camel@work>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752804AbXFKN1L@vger.kernel.org>
In-Reply-To: <1181235539.2610.72.camel@work>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Richard Hughes <hughsient@gmail.com>, Dmitry Torokhov <dtor@insightbb.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Bastien Nocera <hadess@hadess.net>, John Belmonte <john@neggie.net>, linux-acpi <linux-acpi@vger.kernel.org>, Mathieu.Berard@crans.org
List-Id: linux-acpi@vger.kernel.org

Richard Hughes wrote:
> What's the status of this patch? Good for merging? Do you want me to
> redo the current patch using input-polldev and the new setkeycode stuff?

A detail:
I receive error message (no such device) when I try load toshiba_acpi on 
my Toshiba M45-S355 (BIOS is Toshiba and NOT Phoenix).

So, I can't change brightness of LCD.

To solve it, I use omnibook driver available in:
<http://omnibook.sourceforge.net>

Last SVN can get with:
svn export https://svn.sourceforge.net/svnroot/omnibook/omnibook/trunk

With omnibook driver I can change brightness writing in /proc/omnibook/lcd

Only one problem: multimedia keys don't is recognized by xev and I can't 
configure it with omnibook driver.

Best regards,
Renato S. Yamane
