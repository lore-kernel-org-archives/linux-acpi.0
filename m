From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/9] Input: add generic support for sparse keymaps
Date: Fri, 4 Dec 2009 10:19:56 -0800
Message-ID: <20091204181956.GA25669@core.coreip.homeip.net>
References: <20091204060701.28288.91430.stgit@localhost.localdomain> <20091204061158.28288.17664.stgit@localhost.localdomain> <20091204150621.16e4036e@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091204150621.16e4036e@destiny.ordissimo>
Sender: linux-input-owner@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>
Cc: linux-input@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, Harald Welte <laforge@gnumonks.org>, Corentin Chary <corentincj@iksaif.net>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Wu Zhangjin <wuzhangjin@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, Dec 04, 2009 at 03:06:21PM +0100, Anisse Astier wrote:
> On Thu, 03 Dec 2009 22:11:58 -0800, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote :
> 
> > +
> > +/**
> > + * sparse_keymap_report_event - report event corresponding to given key entry
> You meant _report_entry ?
> 

Indeed. Can I add your "Reviewed-by:" please?

-- 
Dmitry
