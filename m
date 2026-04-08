Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FC42BE7DB
	for <linux-acpi@vger.kernel.org>; Wed,  8 Apr 2026 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775663529; cv=none; b=EKBPTyV2duFQBc665InrBka5PNIZOAUxC0iZwfhoRE3gaNBeEK3WqUgcXDoUdBJHCXHC8BEgWRZlfI7/TzNfLSfl2kFgcrBvaOqGF+uZ12ENq7NI3GBEwFtYn1RYUe2uDPxsJQcovoCpz9NrbyQAMTx8iIauNNMSFbUjcU7c904=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775663529; c=relaxed/simple;
	bh=wDiR4ygCxFqa9Z2EhsIwn3+PgH8wQSa11TKy3LcdtZE=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WIX2HRsQF6L5/BU9aR8JSEDhNrvJnR2HwxQSDrVQ/F+8LXe2JVwrFtrsX5KzYcEi/heiLmlT2Z6kGK4pzJ7kGWdLOD/HHdsONwJWBH/TMOnLxvWBmhiXlVtyzHn917SCM1qUwrPFQh6iU7radVs6FMfwyS7TsuHkLsYfQLltodk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLWzx6rJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLWzx6rJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53530C2BCB7
	for <linux-acpi@vger.kernel.org>; Wed,  8 Apr 2026 15:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775663529;
	bh=wDiR4ygCxFqa9Z2EhsIwn3+PgH8wQSa11TKy3LcdtZE=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=uLWzx6rJE5BqWVeE6W452kV4ic5PrsyKyz8uESVJdzYgpuvBcze+QxlnD6nJLabNQ
	 IXNxxhwzDF/I3yVrL/RS+CakL3lanGVaPmV8XkR4WIFPDIIdR/uOj4wQuDsNzRC1Y0
	 j+qqWzATth+LUh24AtOBNix5awTqZ3Tsk8zYROtQ1KU139yXcrFxxhD7lBJRMXjE4b
	 p6QItd/hEgoT/kC6/208Vj3XKcEKtaHtQhSzj4E7qMsXV/jxtX4lNzRwgtBGbGMubL
	 r0Uz3m9izHP9/i/TM35z1/H5shjB3qivBIrQqMvd+SCaW1KXwR6VAyfgK0n5iMfU//
	 T8aUBb2blypjw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a3d2824e4bso5705066e87.3
        for <linux-acpi@vger.kernel.org>; Wed, 08 Apr 2026 08:52:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWkYtRQ7B+5vfMu0zETfz8QBY5Jv/wJSVCkvmKqXw8nd4+qiU1YhnKUSieEFakDuNG8ITYxMjKJggnS@vger.kernel.org
X-Gm-Message-State: AOJu0YwLX40XY+U2PoCsruaQ/mvj7r9LtSX9YAOPjcnq6Cz1Ow9G/bg4
	pDzJAOJxIL4tT9ShM9HxS6TR5Ao8UzY4AJGiNxVY/TOljVvVeCHkxOGKMSFEfd8OKWSqjXvrydg
	rL9lP32X+v69F3oOBJjv1CBvwnCT7YQgIL3q0tZBGPA==
X-Received: by 2002:a05:6512:ad4:b0:5a2:b0ba:7169 with SMTP id
 2adb3069b0e04-5a3e7c4e394mr24919e87.38.1775663527749; Wed, 08 Apr 2026
 08:52:07 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Apr 2026 08:52:06 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Apr 2026 08:52:06 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <DHNVOVO67YMW.1Q763BB153CGF@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407-swnode-unreg-retcode-v4-0-1b2f0725eb9c@oss.qualcomm.com>
 <20260407-swnode-unreg-retcode-v4-1-1b2f0725eb9c@oss.qualcomm.com>
 <CAMRc=MdWSigDmTGSCe-ggAC+rKcCLimKgKU_kAGh5N66jyXGtg@mail.gmail.com> <DHNVOVO67YMW.1Q763BB153CGF@kernel.org>
Date: Wed, 8 Apr 2026 08:52:06 -0700
X-Gmail-Original-Message-ID: <CAMRc=MchUSdWo=BXrYN-qS3YFer2R3J02HyJxKJje-a1QvWdfg@mail.gmail.com>
X-Gm-Features: AQROBzDTUrFlRk0xCpRN_C0GqGwVoKiZ3-raj8rKD_my0S47cg9sJMqXnJQ1eCE
Message-ID: <CAMRc=MchUSdWo=BXrYN-qS3YFer2R3J02HyJxKJje-a1QvWdfg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] software node: return -ENOTCONN when referenced
 swnode is not registered yet
To: Danilo Krummrich <dakr@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Apr 2026 17:28:46 +0200, Danilo Krummrich <dakr@kernel.org> said:
> On Wed Apr 8, 2026 at 9:19 AM CEST, Bartosz Golaszewski wrote:
>> On Tue, Apr 7, 2026 at 3:28=E2=80=AFPM Bartosz Golaszewski
>> <bartosz.golaszewski@oss.qualcomm.com> wrote:
>>>
>>> It's possible that at the time of resolving a reference to a remote
>>> software node, the node we know exists is not yet registered as a full
>>> firmware node. We currently return -ENOENT in this case but the same
>>> error code is also returned in some other cases, like the reference
>>> property with given name not existing in the property list of the local
>>> software node.
>>>
>>> It makes sense to let users know that we're dealing with an unregistere=
d
>>> software node so that they can defer probe - the situation is somewhat
>>> similar to there existing a firmware node to which no device is bound
>>> yet - which is valid grounds for probe deferral. To that end: use
>>> -ENOTCONN to indicate the software node is "not connected".
>>>
>>> Acked-by: Andy Shevchenko <andy@kernel.org>
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.co=
m>
>>> ---
>>
>> Hi Danilo!
>>
>> With Andy's Ack, do you think you could still queue this for v7.1?
>
> Yeah, that should work, but I have a question about the patch.
>
> The comment added to fwnode_property_get_reference_args() says:
>
> 	+ *            %-ENOTCONN when the remote firmware node is a software no=
de that
> 	+ *                       has not been registered as a firmware node yet
>
> This seems like a bit of a layering violation to me, as it makes it expli=
cit
> that this error code indicates a software node, while
> fwnode_property_get_reference_args() itself should be agnostic.
>
> The caller can easily derive more specific semantics with an is_software_=
node()
> check as you already do in the GPIO code.
>
> Can we describe the same condition, but without explicitly naming the bac=
kend?
>

Yes, sure. It can be something like:

	%-ENOTCONN when the remote firmware node exists but has not been
		   registered yet.

Does this sound good and doo you want me to resend or can you change it
when applying?

Bart
