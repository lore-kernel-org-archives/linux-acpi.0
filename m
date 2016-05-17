From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 2/2] logind: Allow lid status remains "closed"
Date: Tue, 17 May 2016 16:27:40 +0800
Message-ID: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472231.git.lv.zheng@intel.com>
References: <c6808078a092fbf990d535cc359b734108ae5d6b.1463472231.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c6808078a092fbf990d535cc359b734108ae5d6b.1463472231.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Bastien Nocera:" <hadess@hadess.net>
List-Id: linux-acpi@vger.kernel.org

This patch adds an option to allow the lid status to remain closed.
However we are not systemd developers, and this patch may be wrong.
It's just a demo on how the issue can be addressed in systemd.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Bastien Nocera: <hadess@hadess.net>
---
Index: systemd/src/login/logind-gperf.gperf
===================================================================
--- systemd.orig/src/login/logind-gperf.gperf
+++ systemd/src/login/logind-gperf.gperf
@@ -29,6 +29,7 @@ Login.PowerKeyIgnoreInhibited,     confi
 Login.SuspendKeyIgnoreInhibited,   config_parse_bool,          0, offsetof(Manager, suspend_key_ignore_inhibited)
 Login.HibernateKeyIgnoreInhibited, config_parse_bool,          0, offsetof(Manager, hibernate_key_ignore_inhibited)
 Login.LidSwitchIgnoreInhibited,    config_parse_bool,          0, offsetof(Manager, lid_switch_ignore_inhibited)
+Login.LidSwitchLevelTriggered,     config_parse_bool,          0, offsetof(Manager, lid_switch_level_triggered)
 Login.HoldoffTimeoutSec,           config_parse_sec,           0, offsetof(Manager, holdoff_timeout_usec)
 Login.IdleAction,                  config_parse_handle_action, 0, offsetof(Manager, idle_action)
 Login.IdleActionSec,               config_parse_sec,           0, offsetof(Manager, idle_action_usec)
Index: systemd/src/login/logind.c
===================================================================
--- systemd.orig/src/login/logind.c
+++ systemd/src/login/logind.c
@@ -62,6 +62,7 @@ static Manager *manager_new(void) {
         m->handle_lid_switch = HANDLE_SUSPEND;
         m->handle_lid_switch_docked = HANDLE_IGNORE;
         m->lid_switch_ignore_inhibited = true;
+        m->lid_switch_level_triggered = true;
         m->holdoff_timeout_usec = 30 * USEC_PER_SEC;
 
         m->idle_action_usec = 30 * USEC_PER_MINUTE;
Index: systemd/src/login/logind.h
===================================================================
--- systemd.orig/src/login/logind.h
+++ systemd/src/login/logind.h
@@ -123,6 +123,7 @@ struct Manager {
         bool suspend_key_ignore_inhibited;
         bool hibernate_key_ignore_inhibited;
         bool lid_switch_ignore_inhibited;
+        bool lid_switch_level_triggered;
 
         bool remove_ipc;
 
Index: systemd/src/login/logind-button.c
===================================================================
--- systemd.orig/src/login/logind-button.c
+++ systemd/src/login/logind-button.c
@@ -123,6 +123,9 @@ static int button_install_check_event_so
         int r;
         assert(b);
 
+        if (!b->manager->lid_switch_level_triggered)
+                return 0;
+
         /* Install a post handler, so that we keep rechecking as long as the lid is closed. */
 
         if (b->check_event_source)
