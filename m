Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B24A38C43D
	for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2026 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774345569; cv=none; b=gh5My/K7IFHai6FWVMBFq8B0evVkHUUTZmeVQoUrp1HsiF4kO62MAHTOIcz74AoYlGIlhcdJWVzVB3005Lgv8ceNpVK3WxY61mxIB3Pn9wauIkPmiqe1n3br38JiV9mOHzgxhFMGw8s3ctRFYRHMswBOBfqPoGheoGYLCkwKJMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774345569; c=relaxed/simple;
	bh=QzfjW2BR42T4tFZISb1hzH87nO0+WjD4yWWDq4E1+4Y=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H79a48zXWgqka/w9TDjI/rhHCSVhzByfjGiYyYGot4eiZONbKNY/HgDAmWRC+cYCB+ezbGA3+XJKbSUvWIDKF+Wwp87Zngsfz6LwB+LqKzO+/LTyj9RFqeJdmiPVPA8mhrEfgovZyasCCd7vuodrpLYW51P1KMJCDDTeckC/02M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UymzNNIU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UymzNNIU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B003C2BCB3
	for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2026 09:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774345569;
	bh=QzfjW2BR42T4tFZISb1hzH87nO0+WjD4yWWDq4E1+4Y=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=UymzNNIUeIVpBYI/an7ftIHu/6tweQUv4vsM1/5eLK7yQk/UiYNXvmjCX9OfT4uVW
	 mjpX6FXDcbmF5SVhd+ZBjT/jlNkrZsaO9IxCC1xHRtyCA+y+NuMS3AYAf+riVpm4QJ
	 a7xQC88J+Yfke60Yor3ZrkLFqQwDKMfh7hW++9bzrXYvDA6LYIOOtC0zk4lNTzyJXe
	 0ui17PIFo70NxNz7mjlVrbGg1fYeE9ZfZdbZWKnzfVOyK2s97MFSU+iSYVpAY91H2A
	 Nbp/cB60Ug0uzaqrtTaar7MG/RHDd/oVkNnbrYMjmH4IikxOhQQxgVsQHCNciJXaeP
	 /P76tFRr7OS7A==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a278e0f7f6so1292101e87.0
        for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2026 02:46:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWiyQ2g7IZv+XJXm7CkrvljzZCGkszCgHs9rbiSXxwiJcTbzq+D3FYnxueGX/d8m/KbD1LBe/KsE3uR@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5YMyMLC2o2ELS6p8ZOfrRHAbCV9HKT7O+bxqTcWQIVZMQ6KI6
	KXAGiQUdzlY01QtSSXk6JaryhFqxapwt/ytf1dCA9b3RoRbsx/O9gWG9MyNRGNImrON5invkbYb
	v2sgB0a+cVo8n6TjUWAwC3a3itbmYT63DbhfsAqcShA==
X-Received: by 2002:a05:6512:3096:b0:5a1:4015:c650 with SMTP id
 2adb3069b0e04-5a285b445a3mr5889925e87.22.1774345567780; Tue, 24 Mar 2026
 02:46:07 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Mar 2026 02:46:06 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Mar 2026 02:46:06 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <acIV6xF8mY-8wd5e@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <acIV6xF8mY-8wd5e@google.com>
Date: Tue, 24 Mar 2026 02:46:06 -0700
X-Gmail-Original-Message-ID: <CAMRc=MdJ0U2_ZQ5rP0Vmbv7+-xurf9F+WOwD3LwV=n5Fx33U=Q@mail.gmail.com>
X-Gm-Features: AaiRm51JQI4nI612gZLIbFqiway6WJxpSAWRqnKy1Ye88UqrV1Xl946U6JPhscc
Message-ID: <CAMRc=MdJ0U2_ZQ5rP0Vmbv7+-xurf9F+WOwD3LwV=n5Fx33U=Q@mail.gmail.com>
Subject: Re: [PATCH] software node: allow referencing software nodes by name
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Mar 2026 05:46:50 +0100, Dmitry Torokhov
<dmitry.torokhov@gmail.com> said:
> Currently static device properties references require either an
> instance of software node or an instance of fwnode_handle to be
> available when defining a reference property. This may not be very
> convenient when device node is instantiated from a different module
> (which is usually the case).
>

For context: this is a follow up to the discussion we had under my alternative
proposal[1]. This should ba an [RFC] too I think.

Probably unsurprisingly, but I'd like to express my opposition to this idea.
The final decision is not mine to make and we have yet to hear from the swnode
and driver core maintainers but I'll present a couple arguments in favor of the
tighter coupling.

> The original implementation for describing GPIOs using software nodes
> worked around this by creating a detached from gpiochip instances
> software nodes, and performing matching using gpiochip label and node
> name. The gpiolib maintainers rightfully questioned this approach, and
> currently recommend to attach secondary software node to gpiochip
> instance, export the symbol, and use it in board file when instantiating
> static properties. This unfortunately results in tight coupling between
> gpiochip drivers and board code, necessitates creation of header files,
> requires adding Kconfig dependencies, limits options for choosing module
> vs built-in compilation, and alters device initialization/probing order.
>

In my first proposal I did in fact create a header and put the software node
definitions in the pinctrl drivers. Andy pointed out, the software nodes should
live inside the android tablet drivers that rely on them and not in the pinctrl
drivers where they would be attached on all the platforms, not only the tiny
number of the ones that need them. I agree with this and plan on changing that
in my v2.

We also discussed the possibility of returning -EPROBE_DEFER if we resolve
a reference to a remote software node that has not yet been registered as
a firmware node[2] as it's a situation similar to a firmware node for which
no device exists yet.

With the above changes to my series, the problems of link order disappear and
we can create real links at build-time with no need to set names of software
nodes (which are typically not required and only used to display them in sysfs,
unless someone uses them for matching the swnodes to devices that is :) ).

IOW: for v2 of my[1] series I propose to put swnode back into the android
tablets drivers but still use the mechanism that will either wait for the
relevant platform device to appear or look up the matching ACPI node. If the
driver tries to resolve the reference before the software node is registered,
it will simply defer probe, though if we can use the ACPI node and not wait
for the platform device, the registration will have typically happened before
the driver even gets registered.

> Solve the issue by providing an option to use software node name in
> place of the node instance when describing reference properties. When
> evaluating reference driver core will attempt to resolve the name to
> concrete node instance and, in case of GPIO references, will use
> identity match on firmware node to locate corresponding gpiochip device.
>
> This approach has a drawback of needing to know name of the node that
> gpiochip device will be using, however benefits (minimal coupling, no
> need for adding dependencies) outweigh this drawback.
>

And it also limits the ways we can match real firmware nodes to their
complementary and puts that limitation into the very driver core. For my v2,
I'd like to propose additional mechanisms for such matching like looking up
the correct ACPI and OF nodes and using unnamed software nodes.

> To deal cases with software nodes not being created or registered at
> time of look up, assume that the node with matching name will get
> registered eventually and return -EPROBE_DEFER in the meantime.
>

I don't think this should happen in core software node code. The -ENOENT
should be interpreted by whatever subsystem tries to resolve the reference.

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

I think that with a few changes to the initial idea, referencing software
nodes by their addresses is the way to go. Keep in mind that this is also
quite the corner-case. In other places we have been typically able to easily
assign the software node to their target fwnode as it would be either a legacy
board file or an MFD driver which already knows its cells' layout and
dependencies.

Thanks,
Bartosz

[1] https://lore.kernel.org/all/20260319-baytrail-real-swnode-v1-0-75f2264ae49f@oss.qualcomm.com/
[2] https://lore.kernel.org/all/CAMRc=MdmuOS-5mHGYtsr3jz654rA9moH4Po_rAFdaPBq-5KCZA@mail.gmail.com/
