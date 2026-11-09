Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794233436;
	b=oM0doRjbOAZLAKHbwKDKnlZgeF2NgX2pY2Fw5q7AQO9J2RyiJKg9XIF3GZvT16hZtR+U
	 ICJHpM14bC84pCMQde8O9cGLB92LQz1GPg15NKx4e+r7s5kZpfChJrF5sLDB0I26Pthd3
	 N8MFQPWAfb8y3jjyxKcNaPWkdeUiQxT4+wmKKrYq1oH0ATmsRCOrmH/QGsQH7QxUS5rUn
	 Q3LM+Aq3o2XN9GTjd0Qm6Kw9EAXzfszpL0c2kO96K/NASLSpZ0B0g7D7kfZfI/ZgS2ORl
	 CKB+e++C0RqXtMGkHsrGU54v7ga4BcxK10X5eRE2u/aCxPrh7zO9SJexrQeEaRpdGZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233436;
	h=Received:DKIM-Signature:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To;
	bh=F/QzRy765sCyCLARXzdq/sxZhb3CwVx21qcDlEi/Kfk=;
	b=XiHqCgpWv/ANqDewcNVMICL9ZL25jWJfcdPncOttGGduhGZ057fr2ohcioL2c+/9nv8Z
	 Ll9D2isytw5JiJt2m2OiidYf0aSyZIu3orJs/4kW/M566SUouqkwocjh7l+Bp9R38YLwK
	 MU7WosWmNdWoPCaIM2KO7GlC+GpJn96CMKIEWTwtFpCxw+QDXkgwPpZF4dHqV8Z4KJEoL
	 J6M05w5sEJPmbhCTvjIEpcGSN3pd6ySp/w0msv6KWmGpGX8la655Y3GFONEHDkWbckIKP
	 FdmUMW05+He+7fTKlvRVSlPkSZql0TbvMeHKVWHk7NC2ZzvHHO/1HfXRvMZD7N/8uqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xq0UbzpK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4F86082BC9;
	Mon,  9 Nov 2026 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xq0UbzpK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62771F008A2;
	Mon,  9 Nov 2026 14:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794233435;
	bh=F/QzRy765sCyCLARXzdq/sxZhb3CwVx21qcDlEi/Kfk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=Xq0UbzpKvt8DSfLRC7AJymY5SAKIBitX+v9SlRhwkVc5DNmgWEW668SPZExywv55e
	 k9ZpJk+JdlsGvycDsZ+L8FfurKTWRFqAuttcC7pC8BzKcuKD1pJZWii+q7AJ99yJ2k
	 CWcJLEE8UuCjmqd0Cs6rtP9MHfpP5ZpEaaNVtLGXfQUan2yFVore427ZdmD4VGzROy
	 00jxELXhxnZVD/lCtrGcjzC0vDPQTqITGjoKUHPrG57Z8W/j8NfJeH1EinaFUMfFl8
	 Egly4JVSUfVkTgmuIKL/V26Ty8Sa08lZz9xT66ZTTAZIGxSNAOHxI+WxNXcaAQvFol
	 fIfMcFeoHvzng==
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Nov 2026 15:10:31 +0100
Message-Id: <DMQQO3DTZE66.1Q2XGGDGN3WUP@kernel.org>
Subject: Re: [PATCH] software node: only let the owner release a managed
 node
Cc: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, "Daniel Scally"
 <djrscally@gmail.com>, "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
 "Sakari Ailus" <sakari.ailus@linux.intel.com>, "Bartosz Golaszewski"
 <brgl@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, <linux-acpi@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 "Balasubramani Vivekanandan" <balasubramani.vivekanandan@intel.com>
To: "Johan Hovold" <johan@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261102-swnode-only-owner-release-v1-1-ee4c9022a629@oss.qualcomm.com> <avHMhh8ChrFE_b_e@hovoldconsulting.com>
In-Reply-To: <avHMhh8ChrFE_b_e@hovoldconsulting.com>

On Mon Nov 9, 2026 at 2:37 PM CET, Johan Hovold wrote:
> On Mon, Nov 02, 2026 at 04:25:16PM +0100, Bartosz Golaszewski wrote:
>> device_create_managed_software_node() creates a node whose lifetime is
>> tied to the device it was created for. software_node_notify_remove() is
>> called for every device that has the node as its fwnode (primary OR
>> secondary) and, if the node is managed, unconditionally detaches it from
>> that device and drops the creation reference.
>>=20
>> This breaks when the node is shared with another device. Example: the
>> i2c-designware copies the parent's fwnode to the adapter's struct device=
.
>> When the adapter is deleted, it releases the reference that belongs to
>> the owner and the latter ends up with a dangling pointer.
>>=20
>> Record the device's "manager" and only perform the actual release when
>> notify is called for that "owner" device.
>>=20
>> Reported-by: Balasubramani Vivekanandan <balasubramani.vivekanandan@inte=
l.com>
>> Closes: https://lore.kernel.org/all/20261009164241.923756-2-balasubraman=
i.vivekanandan@intel.com/
>> Fixes: 151f6ff78cdf ("software node: Provide replacement for device_add_=
properties()")

Hm...the documentation of device_create_managed_software_node() does point =
out
the limitation that it shouldn't be shared with other devices.

Now, that's rather fragile and the reason I pointed out [1] it should be
changed, but it's technically not a fix?

[1] https://lore.kernel.org/all/DM1FMM3KEYU9.1D26IINII93FO@kernel.org/

>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com=
>
>> ---
>> Hi!
>>=20
>> This is my approach at addressing the bug reported by Vivekanandan
>> directly in driver core. Please test it if you can.
>
> This looks good to me, but I think the patch should be simplified somewha=
t.
>
>> @@ -1190,6 +1191,7 @@ void software_node_notify(struct device *dev)
>>  void software_node_notify_remove(struct device *dev)
>>  {
>>  	struct swnode *swnode;
>> +	bool is_owner;
>> =20
>>  	swnode =3D dev_to_swnode(dev);
>>  	if (!swnode)
>> @@ -1206,9 +1208,13 @@ void software_node_notify_remove(struct device *d=
ev)
>>  	if (!device_match_fwnode(dev, &swnode->fwnode) && swnode->fwnode.dev =
=3D=3D dev)
>>  		swnode->fwnode.dev =3D NULL;
>> =20
>> +	is_owner =3D swnode->owner && swnode->owner =3D=3D dev;
>
> The NULL check here is redundant.
>
>> +	if (is_owner)
>> +		swnode->owner =3D NULL;
>
> There is no need to clear the owner field as devices are not allowed to b=
e
> re-registered.

I guess that's true, but maybe leaving in a defined state is a bit more rob=
ust?

>> +
>>  	swnode_put(swnode);
>> =20
>> -	if (swnode->managed) {
>> +	if (is_owner) {
>>  		set_secondary_fwnode(dev, NULL);
>>  		swnode_put(swnode);
>>  	}
>
> And if we drop the managed reference before the notify one, we can drop
> the temporary as well and this chunk just becomes:
>
> @@ -1206,12 +1207,12 @@ void software_node_notify_remove(struct device *d=
ev)
>         if (!device_match_fwnode(dev, &swnode->fwnode) && swnode->fwnode.=
dev =3D=3D dev)
>                 swnode->fwnode.dev =3D NULL;
> =20
> -       swnode_put(swnode);
> -
> -       if (swnode->managed) {
> +       if (swnode->owner =3D=3D dev) {
>                 set_secondary_fwnode(dev, NULL);
>                 swnode_put(swnode);
>         }
> +
> +       swnode_put(swnode);
>  }
>
> The end-result applied for 7.4 (to fix the 7.3 regression) is here:

A previous reply from Balasubramani suggested to adjust the doc-comment of
device_create_managed_software_node(), so I thought Bartosz will send a new
version.

Also, are we sure this is -rc material? I think the original commit wasn't
technically broken and the bug in Xe was fixed otherwise.

Thanks,
Danilo
