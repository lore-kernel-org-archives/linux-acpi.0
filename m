From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 2/3] sony-laptop - simplify keymap initialization
Date: Thu, 24 Dec 2009 19:01:46 -0200
Message-ID: <20091224210146.GA2346@khazad-dum.debian.net>
References: <20091224080135.11511.18604.stgit@localhost.localdomain>
 <20091224080222.11511.79737.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:55850 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755835AbZLXVBu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Dec 2009 16:01:50 -0500
Content-Disposition: inline
In-Reply-To: <20091224080222.11511.79737.stgit@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Mattia Dongili <malattia@linux.it>, linux-acpi@vger.kernel.org

On Thu, 24 Dec 2009, Dmitry Torokhov wrote:
> +	for (i = 0; i < ARRAY_SIZE(sony_laptop_input_keycode_map); i++)
> +		__set_bit(sony_laptop_input_keycode_map[i], key_dev->keybit);
> +	__clear_bit(KEY_RESERVED, key_dev->keybit);

Maybe:

for (i = 0; i < ARRAY_SIZE(sony_laptop_input_keycode_map); i++) {
	if (sony_laptop_input_keycode_map[i] != KEY_RESERVED) {
		input_set_capability(key_dev, EV_KEY,
				sony_laptop_input_keycode_map[i]);
	}
}

would be better, as it means the driver doesn't poke into the inputdev
struct innards directly?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
