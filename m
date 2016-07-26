From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v4 3/3] tools/power/acpi/acpidbg: Add multi-commands support in batch mode
Date: Tue, 26 Jul 2016 19:01:45 +0800
Message-ID: <3492bf600484b4d625be1407013eef0062e6246a.1469528980.git.lv.zheng@intel.com>
References: <cover.1468464391.git.lv.zheng@intel.com> <cover.1469528979.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1469528979.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch adds multi-commands support for the batch mode. The same mode
can be seen in acpiexec.

However people may think this is not useful for an in-kernel debugger,
because the in-kernel debugger is always running, never exits. So we can
run another command by running another acpidbg batch mode instance.

But this mode should still be useful for acpidbg. The reason is: when the
in-kernel debugger has entered the single-stepping mode, ending acpidbg
(which closes the debugger IO interface) will lead to the end of the
single-stepping mode.

So we need the acpidbg multi-commands batch mode in order to execute
multiple single-stepping mode commands in scripts.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 tools/power/acpi/tools/acpidbg/acpidbg.c |   77 +++++++++++++++++++++++++-----
 1 file changed, 64 insertions(+), 13 deletions(-)

diff --git a/tools/power/acpi/tools/acpidbg/acpidbg.c b/tools/power/acpi/tools/acpidbg/acpidbg.c
index f5542b9..99a8f766 100644
--- a/tools/power/acpi/tools/acpidbg/acpidbg.c
+++ b/tools/power/acpi/tools/acpidbg/acpidbg.c
@@ -90,6 +90,7 @@ static char acpi_aml_batch_prompt;
 static char acpi_aml_batch_roll;
 static unsigned long acpi_aml_log_state;
 static char *acpi_aml_batch_cmd = NULL;
+static char *acpi_aml_batch_cmds = NULL;
 static char *acpi_aml_batch_pos = NULL;
 
 static int acpi_aml_set_fl(int fd, int flags)
@@ -326,12 +327,65 @@ static void acpi_aml_loop(int fd)
 	}
 }
 
+static void acpi_aml_delete_batch(void)
+{
+	if (acpi_aml_batch_cmd) {
+		free(acpi_aml_batch_cmd);
+		acpi_aml_batch_cmd = NULL;
+	}
+}
+
+static bool acpi_aml_create_batch(char *cmd)
+{
+	int len;
+
+	acpi_aml_delete_batch();
+	len = strlen(cmd);
+	acpi_aml_batch_cmd = calloc(len + 2, 1);
+	if (!acpi_aml_batch_cmd) {
+		perror("calloc");
+		return false;
+	}
+	memcpy(acpi_aml_batch_cmd, cmd, len);
+	acpi_aml_batch_cmd[len] = '\n';
+	return true;
+}
+
+static void acpi_aml_batch(int fd)
+{
+	char *ptr, *cmd;
+	bool run = false;
+
+	cmd = ptr = acpi_aml_batch_cmds;
+	while (*ptr) {
+		if (*ptr == ',') {
+			/* Convert commas to spaces */
+			*ptr = ' ';
+		} else if (*ptr == ';') {
+			*ptr = '\0';
+			run = true;
+		}
+		ptr++;
+		if (run || (*ptr == '\0')) {
+			if (!acpi_aml_create_batch(cmd))
+				return;
+			ioctl(fd, ACPI_IOCTL_DEBUGGER_FLUSH);
+			acpi_aml_loop(fd);
+			run = 0;
+			cmd = ptr;
+			acpi_aml_delete_batch();
+		}
+	}
+}
+
 void usage(FILE *file, char *progname)
 {
 	fprintf(file, "usage: %s [-b cmd] [-f file] [-h]\n", progname);
 	fprintf(file, "\nOptions:\n");
-	fprintf(file, "  -b     Specify command to be executed in batch mode\n");
-	fprintf(file, "  -f     Specify interface file other than");
+	fprintf(file, "  -b     Specify commands to be executed in batch mode\n");
+	fprintf(file, "         Use ';' as command delimiters\n");
+	fprintf(file, "         Use ',' as spaces\n");
+	fprintf(file, "  -f     Specify interface file other than\n");
 	fprintf(file, "         /sys/kernel/debug/acpi/acpidbg\n");
 	fprintf(file, "  -h     Print this help message\n");
 }
@@ -340,27 +394,23 @@ int main(int argc, char **argv)
 {
 	int fd = -1;
 	int ch;
-	int len;
 	int ret = EXIT_SUCCESS;
 
 	while ((ch = getopt(argc, argv, "b:f:h")) != -1) {
 		switch (ch) {
 		case 'b':
-			if (acpi_aml_batch_cmd) {
+			if (acpi_aml_batch_cmds) {
 				fprintf(stderr, "Already specify %s\n",
-					acpi_aml_batch_cmd);
+					acpi_aml_batch_cmds);
 				ret = EXIT_FAILURE;
 				goto exit;
 			}
-			len = strlen(optarg);
-			acpi_aml_batch_cmd = calloc(len + 2, 1);
-			if (!acpi_aml_batch_cmd) {
-				perror("calloc");
+			acpi_aml_batch_cmds = strdup(optarg);
+			if (!acpi_aml_batch_cmds) {
+				perror("strdup");
 				ret = EXIT_FAILURE;
 				goto exit;
 			}
-			memcpy(acpi_aml_batch_cmd, optarg, len);
-			acpi_aml_batch_cmd[len] = '\n';
 			acpi_aml_mode = ACPI_AML_BATCH;
 			break;
 		case 'f':
@@ -389,8 +439,9 @@ int main(int argc, char **argv)
 	acpi_aml_set_fl(STDOUT_FILENO, O_NONBLOCK);
 
 	if (acpi_aml_mode == ACPI_AML_BATCH)
-		ioctl(fd, ACPI_IOCTL_DEBUGGER_FLUSH);
-	acpi_aml_loop(fd);
+		acpi_aml_batch(fd);
+	else
+		acpi_aml_loop(fd);
 
 exit:
 	if (fd >= 0)
-- 
1.7.10
