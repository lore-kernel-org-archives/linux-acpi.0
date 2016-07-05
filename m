From: Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH] dax: use devm_add_action_or_reset()
Date: Tue, 5 Jul 2016 08:59:04 +0200
Message-ID: <20160705065904.ek4ltpveavadqdqt@c203.arch.suse.de>
References: <1467697807-27067-1-git-send-email-vikas.cha.sajjan@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50972 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754680AbcGEG7R (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Jul 2016 02:59:17 -0400
Content-Disposition: inline
In-Reply-To: <1467697807-27067-1-git-send-email-vikas.cha.sajjan@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vikas C Sajjan <vikas.cha.sajjan@hpe.com>
Cc: dan.j.williams@intel.com, ross.zwisler@linux.intel.com, linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org, linda.knippers@hpe.com

On Tue, Jul 05, 2016 at 11:20:07AM +0530, Vikas C Sajjan wrote:
> If devm_add_action() fails, we are explicitly calling the cleanup to =
free
> the resources allocated. Use the helper devm_add_action_or_reset()
> and return directly in case of error, since the cleanup function
> has been already called by the helper if there was any error.
>=20
> Reported-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Signed-off-by: Vikas C Sajjan <vikas.cha.sajjan@hpe.com>

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

--=20
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=FCrnberg)
Key fingerprint =3D EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
